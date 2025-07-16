//
//  UserServices.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 02/07/25.
//

import Foundation
import Firebase
import FirebaseDatabase



struct UserServices {
    
    static func paginateUsers (lastCursor : String? , pageSize : UInt) async throws -> UserNode {
        
        if lastCursor == nil { // initial fetch
            
            let mainsnapshot = try await FireBaseConstants.Reference.queryLimited(toLast: pageSize).getData()
            
            guard let firstsnapshot = mainsnapshot.children.allObjects.first as? DataSnapshot ,
                  
                    let allObjects = mainsnapshot.children.allObjects as? [DataSnapshot] else {
                
                return UserNode.emptyNode
            }
            
            let users : [UserItem] = allObjects.compactMap { usersnapshot in
                let userDict = usersnapshot.value as? [String : Any] ?? [:]
                
                return UserItem(dictionary: userDict)
                
                
            }
            
            if users.count == mainsnapshot.childrenCount {
                let userNode = UserNode(users: users, currentCursor: firstsnapshot.key)
                
                print("\(lastCursor)")
                return userNode
            }
            
            return .emptyNode
        }
       
            else {
               
                let mainsnapshot = try await FireBaseConstants.Reference
                    .queryOrderedByKey()
                    .queryLimited(toLast: pageSize+1)
                    .queryEnding(atValue: lastCursor)
                    .getData()
                
                
                guard let firstSnapshot = mainsnapshot.children.allObjects.first as? DataSnapshot ,
                      
                        let allObjects = mainsnapshot.children.allObjects as? [DataSnapshot] else {
                    
                    return UserNode.emptyNode
                }
                
                let users : [UserItem] = allObjects.compactMap { user in
                    let userDict = user.value as? [String : Any] ?? [:]
                    
                   return UserItem(dictionary: userDict)
                }
                
                if users.count == mainsnapshot.childrenCount {
                    
                    
                    let filrteredUsers = users.filter {$0.uid != lastCursor}
                    
                    let userNode = UserNode(users: filrteredUsers, currentCursor: firstSnapshot.key)
                     
                    return userNode
                }
                return .emptyNode
            }
            
        }
    }


struct UserNode {
    var users : [UserItem]
    var currentCursor : String?
    
    
    static let emptyNode = UserNode(users: [], currentCursor: nil)
}
// remember again don't complicate snapshot it's just the result that is being fetched and sent from the data base


/*
 users
 
 username : **************
 uid : **************
 email : *************
 */
// the above one is one snapshot
