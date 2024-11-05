import Foundation

class AppDataManager: @unchecked Sendable {
  static let shared: AppDataManager = AppDataManager()

  private let fileManager = FileManager.default

  // MARK: - Path Management
  private var currentDirectoryURL: URL {
    URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
  }

  // MARK: - Initialization
  private init() {
    setupDirectories()
  }

  private func setupDirectories() {
    let dataDirectory = currentDirectoryURL.appendingPathComponent("data")

    do {
      try fileManager.createDirectory(
        at: dataDirectory,
        withIntermediateDirectories: true
      )
    } catch {
      print("Failed to setup directories: \(error)")
    }
  }

  // MARK: - Save and Load Functions
  func saveData<T: Encodable>(_ data: T, filename: String) throws {
    let fileURL = currentDirectoryURL.appendingPathComponent("data").appendingPathComponent(
      filename)

    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      encoder.dateEncodingStrategy = .iso8601

      let jsonData = try encoder.encode(data)
      try jsonData.write(to: fileURL)
    } catch {
      throw error
    }
  }

  func loadData<T: Decodable>(_ type: T.Type, filename: String) throws -> T {
    let fileURL = currentDirectoryURL.appendingPathComponent("data").appendingPathComponent(
      filename)

    do {
      let data = try Data(contentsOf: fileURL)
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      return try decoder.decode(type, from: data)
    } catch {
      throw error
    }
  }

  // MARK: - Utility Functions
  func fileExists(filename: String) -> Bool {
    let fileURL = currentDirectoryURL.appendingPathComponent("data").appendingPathComponent(
      filename)
    return fileManager.fileExists(atPath: fileURL.path)
  }

  func deleteFile(filename: String) throws {
    let fileURL = currentDirectoryURL.appendingPathComponent("data").appendingPathComponent(
      filename)

    if fileManager.fileExists(atPath: fileURL.path) {
      try fileManager.removeItem(at: fileURL)
    }
  }

  // Add this temporary debug method
  func log() {
    print("💾 Saved activity to: \(currentDirectoryURL.appendingPathComponent("data").path) \n")
  }
}
