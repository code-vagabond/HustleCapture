//
//  Vision.swift
//  HustleCastCapture
//
//  Created by Linh Phung on 05.11.24.
//

import Foundation
import ScreenCaptureKit
import AppKit
import Vision

func capture() async -> CGImage? {

        do {
            // Get the main display
            guard let mainDisplay = try await SCShareableContent.current.displays.first else {
                print("No display found")
                return nil
            }

            // Create an SCStreamConfiguration with preset for HDR.
            let config = SCStreamConfiguration()
            config.capturesAudio = false
            config.width = Int(mainDisplay.width)
            config.height = Int(mainDisplay.height)


            // Get all running applications
            let scApps = try await SCShareableContent.current.applications

            // Get the currently active app
            let activeNSApp = NSWorkspace.shared.frontmostApplication
            // Filter out system apps if needed

            
            let activeApp = NSWorkspace.shared.frontmostApplication
            
            // If the active app is found, use it; otherwise, use the first app in the list
            let appToCapture = scApps.first { $0.bundleIdentifier == activeApp?.bundleIdentifier }

            
            guard let appToCapture = appToCapture else {
                print("No suitable app found for capture")
                return nil
            }
            
           
            // Print app title and description
            print("App Title: \(appToCapture.applicationName)")
            print("App Description: \(appToCapture.bundleIdentifier)")
            
            
            // Create a content filter for the main display
            let filter = SCContentFilter(display: mainDisplay, including: [appToCapture], exceptingWindows: [])
            
            // Call the screenshot API and get your screenshot image
            if let screenshot = try? await SCScreenshotManager.captureImage(contentFilter: filter, configuration: config) {
                return screenshot
            } else {
                print("Failed to fetch screenshot.")
                return nil
            }
            // Process the screenshot here...
            
        } catch {
            print("Error capturing screenshot: \(error)")
            return nil
        }
}


func extractText(from image: CGImage) -> String? {
    // Create a Vision request to recognize text
    let request = VNRecognizeTextRequest()
    request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
    
    // Create a handler that uses the input image
    let handler = VNImageRequestHandler(cgImage: image, options: [:])
    
    do {
        // Perform the request
        try handler.perform([request])
        
        // Get the recognized text
        guard let observations = request.results else {
            return nil
        }
        
        // Combine all recognized text
        let recognizedText = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
        
        return recognizedText
    } catch {
        print("Error extracting text: \(error)")
        return nil
    }
}


