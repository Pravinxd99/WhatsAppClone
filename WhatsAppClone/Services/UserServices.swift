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
    
    static func getUsers (with uids : [String] , completion : @escaping (UserNode) -> Void) {
        var users = [UserItem]()
        
        for uid in uids {
            let query =  FireBaseConstants.UserReference.child(uid)
            query.observeSingleEvent(of: .value) { snapshot in
                guard let user = try? snapshot.data(as: UserItem.self) else {return}
                
                users.append(user)
                
                if users.count == uids.count {
                    completion(UserNode(users: users))
                }
            } withCancel: { error in
                completion(.emptyNode)
            }

        }
        
    }
    
    static func paginateUsers (lastCursor : String? , pageSize : UInt) async throws -> UserNode {
        
        if lastCursor == nil { // initial fetch
            
            let mainsnapshot = try await FireBaseConstants.UserReference.queryLimited(toLast: pageSize).getData()
            
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
                
                print("LAST CURSOR :\(lastCursor)")
                return userNode
            }
            
            return .emptyNode
        }
       
            else {
               
                let mainsnapshot = try await FireBaseConstants.UserReference
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
