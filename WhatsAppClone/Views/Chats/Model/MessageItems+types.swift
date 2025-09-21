//
//  MessageItems+types.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 12/07/25.
//

import Foundation


enum AdminMessageType : String {
    
    case channelCreation
    case memberAdded
    case memberLeft
    case channelNameChanged
}



extension String {
    
    static let type = "type"
    static let creationTime = "creationtime"
    static let owneruid = "owneruid"
    static let text = "text"
    
}

enum MessageDirection  {
    case sent , received
    
   static  var random : MessageDirection {
        return [.sent , .received].randomElement() ?? .sent
    }
}

enum MessageType {
    case text , video , image , audio
    
    var title : String {
        switch self {
        case .text:
            "text"
        case .video:
            "video"
        case .image:
            "image"
        case .audio:
            "audio"
        }
    }
    
    init(_ stringValue : String) {
        switch stringValue {
            
        case "text" :
            self = .text
        case "video" :
            self = .video
        case "photo" :
            self = .image
            
        default :
            self = .text
        }
    }
}
