//
//  MessageItem.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import Foundation
import SwiftUI
import FirebaseAuth

struct MessageItem {
    var timeStamp : Date
    var showGroupPartnerInfo : Bool {
        return direction == .received && isGroupChat
    }
    var sender : UserItem?
    var message : String
    var id : String
    var direction : MessageDirection {
        return ownerUid == Auth.auth().currentUser?.uid ? .sent : .received
    }
    var isGroupChat : Bool
    var messageType : MessageType
    let ownerUid : String
   
    var horizontalAlignment : HorizontalAlignment {
        return direction == .received ? .leading : .trailing
    }
    var alignment : Alignment {
        return direction == .received ? .leading : .trailing
    }
    var backgroundColor : Color {
        direction == .sent ? Color.bubbleGreen : Color.bubbleWhite
    }
    var trailingPadding : CGFloat {
        return direction == .received ? horizontalPadding : 0
    }
    var leadingPadding : CGFloat {
        return direction == .received ? 0 : horizontalPadding
    }
    
    var horizontalPadding : CGFloat = 25

    static let receivedMessageItem = MessageItem(timeStamp: Date(), message: "Ethu Nagarjunavaa", id: UUID().uuidString, isGroupChat: false, messageType: .text, ownerUid: "1")
    static let sentMessageItem = MessageItem(timeStamp: Date(), message: "Whats up broskiee", id: UUID().uuidString, isGroupChat: true, messageType: .text, ownerUid: "2" )
   
    
    static let differentKindOfMessages : [MessageItem] = [MessageItem(timeStamp: Date(), message: "hi its a text message", id: UUID().uuidString, isGroupChat: false, messageType: .text, ownerUid: "5"),
                                                          MessageItem(timeStamp: Date(), message: "hi its a image message", id: UUID().uuidString, isGroupChat: false, messageType: .image, ownerUid: "6"),
                                                          MessageItem(timeStamp: Date(), message: "hi its a video message", id: UUID().uuidString, isGroupChat: true, messageType: .video, ownerUid: "7"),
                                                          MessageItem(timeStamp: Date(), message: "hi its a audio message", id: UUID().uuidString, isGroupChat: true, messageType: .audio, ownerUid: "8")]
}
extension MessageItem {
    init( id : String , isGroupChat : Bool ,dict : [String : Any]) {
        self.id = id
        self.isGroupChat = isGroupChat
        self.message = dict[.text] as? String ?? ""
        let type = dict[.type] as? String ?? "text"
        self.messageType = MessageType(type) ?? .text
        self.ownerUid = dict[.owneruid] as? String ?? ""
        let date = dict[.creationTime] as? TimeInterval ?? 0
        self.timeStamp = Date(timeIntervalSince1970: date)
    }
}

