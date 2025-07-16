//
//  Helper.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 17/02/25.
//

import Foundation
import Firebase
import FirebaseStorage


enum FireBaseConstants {
    
    static let FirebaseReference = Database.database().reference()
    static let Reference = FirebaseReference.child("users")
    static let ChannelsReference = FirebaseReference.child("channels")
    static let MessagesReference = FirebaseReference.child("channel-messages")
    static let UserchannelReference = FirebaseReference.child("user-channels")
    static let UserdirectChannels = FirebaseReference.child("user-direct-channels")
}
  
