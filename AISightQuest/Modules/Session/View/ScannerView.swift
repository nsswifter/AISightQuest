//
//  ScannerView.swift
//  AISightQuest
//
//  Created by Mehdi Karami on 2/25/24.
//

import SwiftUI
import VisionKit

// MARK: - Scanner View

struct ScannerView: UIViewControllerRepresentable {
    private let completionHandler: ([String]?) -> Void
    
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler = completion
    }
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let viewController = VNDocumentCameraViewController()
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator { Coordinator(completion: completionHandler) }
    
    final class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler: ([String]?) -> Void
        
        init(completion: @escaping ([String]?) -> Void) {
            completionHandler = completion
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            Task {
                do {
                    completionHandler(try await TextRecognizer(cameraScan: scan).recognizeText())
                } catch {
                    print("Error recognizing text: \(error)")
                    completionHandler(nil)
                }
            }
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            completionHandler(nil)
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            completionHandler(nil)
        }
    }
}
