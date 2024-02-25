//
//  TextRecognizer.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import Vision
import VisionKit

// MARK: - Text Recognizer

final class TextRecognizer {
    let cameraScan: VNDocumentCameraScan
    
    init(cameraScan: VNDocumentCameraScan) {
        self.cameraScan = cameraScan
    }
    
    func recognizeText() async throws -> [String] {
        try await withThrowingTaskGroup(of: String.self) { group in
            for pageIndex in 0..<cameraScan.pageCount {
                group.addTask {
                    try self.recognizeText(in: self.cameraScan.imageOfPage(at: pageIndex).cgImage!)
                }
            }
            
            var textPerPage: [String] = []
            for try await result in group {
                textPerPage.append(result)
            }
            return textPerPage
        }
    }
    
    private func recognizeText(in image: CGImage) throws -> String {
        let request = VNRecognizeTextRequest()
        request.recognitionLevel = .accurate
        let handler = VNImageRequestHandler(cgImage: image, options: [:])
        try handler.perform([request])
        
        guard let observations = request.results else { return "" }
        
        let recognizedText = observations.compactMap { observation in
            observation.topCandidates(1).first?.string
        }.joined(separator: "\n")
        
        return recognizedText
    }
}
