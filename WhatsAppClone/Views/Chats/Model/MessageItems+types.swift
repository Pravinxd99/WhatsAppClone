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
}

enum MessageDirection  {
    case sent , received
    
   static  var random : MessageDirection {
        return [.sent , .received].randomElement() ?? .sent
    }
}

enum MessageType {
case text , video , image , audio
}
