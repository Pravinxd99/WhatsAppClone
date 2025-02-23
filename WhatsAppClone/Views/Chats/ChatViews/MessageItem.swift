//
//  MessageItem.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import Foundation
import SwiftUI

struct MessageItem {
    
    var message : String
    var uuid = UUID().uuidString
    var direction : MessageDirection
    var messageType : MessageType
    
    var horizontalAlignment : HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    var alignment : Alignment {
        return direction == .received ? .leading : .trailing
    }
    var backgroundColor : Color {
        direction == .sent ? Color.bubbleGreen : Color.bubbleWhite
    }
    static let receivedMessageItem = MessageItem(message: "How are you bro , you alright ?", uuid: "80908y7t6r", direction: .received, messageType: .text)
    static let sentMessageItem = MessageItem(message: "How are you doing", uuid: "80908y7t6r", direction: .sent, messageType: .text)
    static let randomtMessageItem = MessageItem(message: "How are you doing bro", uuid: "80908y7t6r", direction: .random, messageType: .text)
    
    static let differentKindOfMessages : [MessageItem] = [ MessageItem(message: "Text Message", direction: .sent, messageType: .text), MessageItem(message: "image message", direction: .received, messageType: .image) , MessageItem(message: "Video message", direction: .sent, messageType: .video) , MessageItem(message: "AudioMessage", direction: .sent, messageType: .audio) , MessageItem(message: "AudioMessage", direction: .received, messageType: .audio)]
    
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
