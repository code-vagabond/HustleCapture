# HustleCapture

HustleCapture is a command-line tool that captures and analyzes your active application usage using OCR (Optical Character Recognition) technology.

## Features

- Captures the currently active application window
- Extracts text content using Vision framework OCR
- Integrates with OpenAI API for text processing
- Runs continuously in the background
- Saves activity data to JSON files

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
