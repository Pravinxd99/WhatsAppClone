//
//  PhotoPickerItem.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 06/01/26.
//

import Foundation
import SwiftUI
import PhotosUI
extension PhotosPickerItem {
    var isVideo : Bool {
        
        let videoUTTypes : [UTType] = [
            .avi,
            .appleProtectedMPEG4Audio,
            .appleProtectedMPEG4Video,
            .mp3,
            .movie,
            .audio,
            .video,
            .mpeg,
            .mpeg2Video,
            .mpeg4Audio,
            .mpeg4Movie,
            .quickTimeMovie,
            .audiovisualContent  
        ]
        return videoUTTypes.contains(where: supportedContentTypes.contains)
    }
}
