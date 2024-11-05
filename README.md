# HustleCapture

HustleCapture is a command-line tool that captures and analyzes your active application usage using OCR (Optical Character Recognition) technology.

## Features

- Captures the currently active application window
- Extracts text content using Vision framework OCR
- Integrates with OpenAI API for text processing
- Runs continuously in the background
- Saves activity data to JSON files

## Example output

```json
[
  {
    "content": "The user is working on a Swift coding project titled \"HustleCapture.\" They are debugging and reviewing code specifically within the \"OCRManager.swift\" file, which involves handling optical character recognition (OCR) functionality. The text includes references to building the project, managing threads, and ensuring the command-line tool remains running. The user is making adjustments to timer and RunLoop implementations in the code.",
    "timestamp": "2024-11-05T13:54:21Z",
    "appName": "Cursor",
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92"
  },
  {
    "content": "The user is actively working on a Swift coding project named \"HustleCapture.\" They are debugging and refining the code in the \"OCRManager.swift\" file, focusing on implementing optical character recognition functionality. The screen displays details about handling timers and RunLoop management to ensure the command-line tool remains operational during execution. The user is also building the project and managing associated JSON data files.",
    "timestamp": "2024-11-05T13:54:31Z",
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92",
    "appName": "Cursor"
  },
  {
    "timestamp": "2024-11-05T13:59:46Z",
    "content": "The user is browsing Google Search for information on displaying emojis in various terminal environments. The search terms include references to Python, Linux, and Mac, indicating an interest in coding or scripting related to emoji output in terminals. Additionally, there are indications of other web applications and services open, such as Gmail and various bookmarks.",
    "appName": "Google Chrome",
    "bundleIdentifier": "com.google.Chrome"
  },
  {
    "bundleIdentifier": "com.google.Chrome",
    "appName": "Google Chrome",
    "timestamp": "2024-11-05T13:59:56Z",
    "content": "The user is browsing a stack exchange page on Ask Ubuntu, looking for information on using emojis inside a terminal. There are discussions and answers regarding compatibility with different applications and settings to enable emojis within terminal environments. The content includes technical details about Ubuntu versions, font issues, and related questions about terminal functionalities."
  },
  {
    "appName": "Cursor",
    "timestamp": "2024-11-05T14:00:06Z",
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92",
    "content": "The user is coding in Swift using Visual Studio Code, working on a project called \"HustleCapture.\" They are implementing file management functions in the `DataManager.swift` file, including methods for checking file existence and deleting files. The user is also executing the project from the terminal, which involves building and running the application with an OpenAI API key as a parameter. There is an active discussion about handling Swift build artifacts and terminal emoji usage."
  },
  {
    "content": "The user is coding in Swift using Visual Studio Code, specifically working on a project called \"HustleCapture.\" They are editing the \"OCRManager.swift\" file, focusing on text extraction and saving functionalities. The user is also executing the project in the terminal and reviewing build and compilation information related to Swift. Additionally, there are discussions about build artifact management and terminal emoji usage.",
    "timestamp": "2024-11-05T14:00:16Z",
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92",
    "appName": "Cursor"
  },
  {
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92",
    "content": "The user is coding in Swift using Visual Studio Code, specifically working on a project called \"HustleCapture.\" They are editing the \"OCRManager.swift\" file, which handles text extraction and saving functionalities. The user is also referencing discussions about compilation, build management, and emoji usage in terminal environments. The activity includes executing the project, reviewing build information, and managing Swift build artifacts.",
    "appName": "Cursor",
    "timestamp": "2024-11-05T14:00:26Z"
  },
  {
    "content": "The user is coding in Swift using Visual Studio Code, focusing on a project named \"HustleCapture.\" They are editing the \"OCRManager.swift\" file, which involves implementing text extraction and saving functionalities. The user is also managing build artifacts and discussing compilation processes, as well as running the project with an OpenAI API key via terminal commands.",
    "appName": "Cursor",
    "timestamp": "2024-11-05T14:00:36Z",
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92"
  },
  {
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92",
    "appName": "Cursor",
    "content": "The user is coding in Swift using Visual Studio Code, working on a project named \"HustleCapture.\" They are editing the \"OCRManager.swift\" file, which involves text extraction and saving functionalities. The user is also managing build artifacts, discussing compilation processes, and executing the project via terminal commands, specifically referencing OpenAI API integration.",
    "timestamp": "2024-11-05T14:00:46Z"
  },
  {
    "content": "The user is actively coding in Swift using Visual Studio Code, focusing on the \"HustleCapture\" project. They are editing the \"OCRManager.swift\" file, which pertains to text extraction and saving functionality. The user is also involved in managing build artifacts, compiling code, and executing commands in the terminal, potentially related to OpenAI API integration. Additionally, they are reviewing details about build processes and troubleshooting.",
    "appName": "Cursor",
    "timestamp": "2024-11-05T14:00:56Z",
    "bundleIdentifier": "com.todesktop.230313mzl4w4u92"
  }
]
```

## Requirements

- macOS 10.15 or later
- Xcode 13.0 or later
- Swift 5.5 or later
- OpenAI API key

## Installation

1. Clone the repository
2. In the project directory, build the project:

```
swift build
```

3. Run the tool:

```
swift run HustleCapture --key <your-openai-api-key>
```

Data is saved to `data/activity_entries.json`.
