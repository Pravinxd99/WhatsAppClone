//
//  MessageServices.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 30/08/25.
//

import Foundation


struct MessageServices {
    
    static func sendTextMessage (to channel : ChannelItem , from user : UserItem , textMessage : String , onComplete : () -> Void ) {
        
        guard let messageId = FireBaseConstants.MessagesReference.childByAutoId().key else {return}
        let timeStamp = Date().timeIntervalSince1970
        let channelDict : [String : Any] = [
            .lastMessageTimeStamp : timeStamp,
            .lastMessage : textMessage
                    
        ]
        let messageDict : [String : Any] = [
            .creationTime : timeStamp ,
            .type : MessageType.text.title ,
            .text : textMessage,
            .owneruid : user.uid
        ]
        FireBaseConstants.ChannelsReference.child(channel.id).updateChildValues(channelDict)
        FireBaseConstants.MessagesReference.child(channel.id).child(messageId).setValue(messageDict)
        onComplete()
        
    }
    
    
    static func getMessagesFromDB ( channel : ChannelItem , completion : @escaping ([MessageItem]) -> Void) {
        
        FireBaseConstants.MessagesReference.child(channel.id).observe(.value) { snapshot in
            guard let dict = snapshot.value as? [String : Any] else { return }
            var messages : [MessageItem] = []
            dict.forEach { key , value in
                let messageDict = value as? [String : Any] ?? [:]
                let message = MessageItem(id: key, isGroupChat: channel.isGroupChat,  dict: messageDict)
                messages.append(message)
                if messages.count == snapshot.childrenCount {
                    messages.sort { $0.timeStamp < $1.timeStamp}
                        completion(messages)
                    }
                }
            
        } withCancel: { error in
            print("Error getting messages from \(channel.title)")
        }

    }
}
