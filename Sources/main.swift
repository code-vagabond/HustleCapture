//
//  main.swift
//  HustleCastCapture
//
//  Created by Linh Phung on 05.11.24.
//

import ArgumentParser
import Foundation

struct HustleCapture: ParsableCommand {
  @Option(help: "OpenAI API key")
  public var key: String

  public func run() throws {
    print("HustleCapture started!")
    let ocrManager = OCRManager(apiKey: key)
    ocrManager.startOcrTimer()
  }
}

HustleCapture.main()
