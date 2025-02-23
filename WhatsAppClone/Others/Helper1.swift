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
    
    static let FirebaseeReference = Database.database().reference()
    static let Reference = FirebaseeReference.child("users")
}
