import Alamofire
import AppKit
import ArgumentParser
import Foundation

// Define your data model
struct ActivityEntry: Codable {
  let content: String
  let timestamp: Date
  let bundleIdentifier: String
  let appName: String
}

// Save screen texts
func saveContent(_ text: String, bundleId: String, appName: String) {
  let activityEntry = ActivityEntry(
    content: text,
    timestamp: Date(),
    bundleIdentifier: bundleId,
    appName: appName
  )

  do {
    var entries: [ActivityEntry] = []
    if AppDataManager.shared.fileExists(filename: "activity_entries.json") {
      entries = try AppDataManager.shared.loadData(
        [ActivityEntry].self, filename: "activity_entries.json")
    }

    entries.append(activityEntry)
    AppDataManager.shared.log()
    try AppDataManager.shared.saveData(entries, filename: "activity_entries.json")
  } catch {
    print("Error saving activity entry: \(error)")
  }
}

class OCRManager: @unchecked Sendable {
  private let apiKey: String

  init(apiKey: String) {
    self.apiKey = apiKey
  }

  func startOcrTimer() {
    // Create a timer on the main thread instead
    let timer = Timer(timeInterval: 10.0, repeats: true) { [weak self] _ in
      print("Reading screen and saving text")
      Task {
        await self?.readScreenAndSaveText()
      }
    }
    RunLoop.main.add(timer, forMode: .default)
    // Keep the main thread's RunLoop running
    RunLoop.main.run()
  }

  private func readScreenAndSaveText() async {
    if let image = await capture() {
      if let text = extractText(from: image) {
        let activeApp = NSWorkspace.shared.frontmostApplication
        let bundleId = activeApp?.bundleIdentifier ?? ""
        let appName = activeApp?.localizedName ?? ""

        do {
          let activity = try await deduceActivity(screenText: text, bundleIdentifier: bundleId)
          print("Activity: \(activity)")
          saveContent(activity, bundleId: bundleId, appName: appName)
        } catch {
          print("Error deducing activity: \(error)")
        }
      }
    }
  }

  private func deduceActivity(screenText: String, bundleIdentifier: String) async throws -> String {
    let prompt = """
      Screen Text: \(screenText)
      """

    let url = "https://api.openai.com/v1/chat/completions"
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(apiKey)",
      "Content-Type": "application/json",
    ]

    let parameters: [String: Sendable] = [
      "model": "gpt-4o-mini",
      "max_tokens": 100,
      "messages": [
        [
          "role": "system",
          "content": """
          You are an screen context analyzer. Given the application bundle identifier and extracted text from the user's screen, 
          deduce what the user is doing. The bundle identifier (e.g. com.apple.Xcode for coding, 
          com.google.Chrome for browsing) provides the application context, while the screen text 
          gives specific details about the user is reading about.
          Describe objectively what the user is looking at.
          Be concise and to the point. Keep it under 100 completion tokens. Don't include words like "I think" or "I believe".
          If there is too little context, just return "No context".
          """,
        ],
        ["role": "user", "content": prompt],
      ],
    ]

    let response = try await AF.request(
      url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers
    )
    .serializingDecodable(OpenAIResponse.self)
    .value

    return response.choices[0].message.content
  }
}

struct OpenAIResponse: Decodable {
  struct Choice: Decodable {
    struct Message: Decodable {
      let content: String
    }
    let message: Message
  }
  let choices: [Choice]
}
