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
    case text , video , image , audio , admin(type : AdminMessageType)
    
    init?(_ stringValue : String) {
        switch stringValue {
            
        case .text :
            self = .text
        case "video" :
            self = .video
        case "photo" :
            self = .image
            
        default:
            if let adminMessageType = AdminMessageType(rawValue: stringValue ) {
                self = .admin(type: adminMessageType)
            }
            else {
                return nil
            }
        }
    }
    
    var title : String {
        switch self {
        case .text:
            return "text"
        case .video:
            return "video"
        case .image:
            return "image"
        case .audio:
            return "audio"
       
        case .admin(type: let _type):
            return "admin"
        }
    }
    
    
}

extension MessageType : Equatable {
    
    static func == (lhs : MessageType , rhs : MessageType) -> Bool {
        switch (lhs , rhs) {
        case (.text , .text) , (.audio , .audio) , (.video , .video),(.image , .image) :
            return true
        case (.admin(let leftAdmin) , .admin(type: let rightAdmin)):
            return leftAdmin == rightAdmin
        default :
            return false
        }
        
        
    }
}
