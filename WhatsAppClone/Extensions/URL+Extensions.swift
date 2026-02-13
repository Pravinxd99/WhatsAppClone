//
//  URL+Extensions.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 12/02/26.
//

import Foundation
import UIKit
import AVKit
extension URL {
   
    static var stubUrl : URL  {
        return URL(string: "httpe://www.google.com")!
    }
    func generateThumbnail () async throws -> UIImage? {
        let asset = AVURLAsset(url: self)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 1, preferredTimescale: 60)
        
        return try await withCheckedThrowingContinuation { continuation in
            imageGenerator.generateCGImageAsynchronously(for: time) { cgImage, _, error in
                if let cgImage = cgImage {
                    let thumbnail = UIImage(cgImage: cgImage)
                    continuation.resume(returning: thumbnail)
                }
                else {
                    continuation.resume(throwing: error ?? NSError(domain: "", code: 0))
                }
            }
        }
        }
    }

