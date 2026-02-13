//
//  MediaPickerItems_Types.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 06/01/26.
//

import Foundation
import SwiftUI

struct VideoPickerTransferable : Transferable {
    let url : URL
    
    static var transferRepresentation : some TransferRepresentation {
        FileRepresentation(contentType:.movie){ exportingFile in
            return .init(exportingFile.url) // this gets triggered when user sends something from whatsapp ie click share to another app
            
        }importing: { receivedTransferredFile in // this is for importing ie when the user imports something from gallery
            let originalFile = receivedTransferredFile.file // legit file
            let uniqueFileName = "\(UUID().uuidString).mov" // creating a unique name so in future it doesn't affect any existing file names
            let copiedFile = URL.documentsDirectory.appendingPathComponent(uniqueFileName) // getting the URL to locate the file in the furture
            try FileManager.default.copyItem(at: originalFile, to: copiedFile) // copy the file in the disk so it stays in the app sandbox
            return .init(url: copiedFile)
        }
    }// all things are handled via URL here not the file itself
   
}

struct MediaAttachment : Identifiable {
    var id : String
    var type : MediaAttachmentTypes
    
    var thumbNail : UIImage {
        switch type {
        case .photo(let thumbNail):
            return thumbNail
        case .video(let thumbNail, let url):
            return thumbNail
        case .audio:
            return UIImage()
        }
    }
}

enum MediaAttachmentTypes : Equatable {
    case photo (_ thumbNail : UIImage)
    case video(_ thumbNail : UIImage , _ url : URL)
    case audio
    
    static func == (lhs : MediaAttachmentTypes , rhs : MediaAttachmentTypes) -> Bool {
        switch (lhs , rhs ) {
        case (.audio , .audio) , (.video , .video) , (.photo , .photo) :
            return true
            
        default :
            return false
        }
    }
}

