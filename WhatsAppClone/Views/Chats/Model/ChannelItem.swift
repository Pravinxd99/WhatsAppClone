//
//  ChannelItem.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 05/07/25.
//

import Foundation
import FirebaseAuth


struct ChannelItem: Identifiable  {
    
    var id : String
    var name : String?
    var lastMessage : String
    var channelCreationDate : Date
    var lastMessageTimeStamp : Date
    var members :[UserItem]
    var membersCount : Int
    var membersuid : [String]
    var adminuid :[String]
    private var thumbnailUrl : String?
    var createdBy : String
    
    var coverImageUrl : String? {
        if let thumbnailUrl = thumbnailUrl {
            return thumbnailUrl
        }
        if isGroupChat ==  false {
            return membersExcludingMe.first?.profileImage
        }
        return nil 
    }
    
    var creatorName : String {
        members.first{$0.uid == createdBy}?.username ?? "Someone"
    }
    var isCreatedByMe : Bool {
        if createdBy == Auth.auth().currentUser?.uid {
            return true
        }
        else {
            return false
        }
    }
    var isGroupChat : Bool {
        
        self.membersCount > 2
    }
    var membersExcludingMe : [UserItem] {
        
        return members.filter { $0.uid != Auth.auth().currentUser!.uid}
        
    }
    
    var title : String
    {
        if let name = name {
            return name
        }
        
        else if  isGroupChat {
            return    getGroupChatName }
        
        else{
            return  membersExcludingMe.first?.username ?? "Unknown"
        }
        
    }
    
    
    var getGroupChatName : String {
        
        let membersCount = membersExcludingMe.count
        let memberNames : [String] = membersExcludingMe.map{$0.username}
        
        if membersCount == 2 {
            
            return memberNames.joined(separator: " and ")
        }
        else if membersCount > 2 {
            let remainingCount = membersCount - 2
            return  memberNames.prefix(2).joined(separator: "," ) + " ,and \(remainingCount) + others"
        }
        
        return "Unknown"
    }
    
    static let sampleChannelItem : ChannelItem = ChannelItem(id: "1", lastMessage: "This is the last message", channelCreationDate: Date(), lastMessageTimeStamp: Date(), members: [], membersCount: 5, membersuid: [], adminuid: [], createdBy: "")
        
        
    
}


extension String {
    
    static let id = "id"
    static let name = "name"
    static let lastMessage = "lastMessage"
    static let channelCreationDate = "channelCreationDate"
    static let lastMessageTimeStamp = "lastMessageTimeStamp"
    static let members  = "members"
    static let membersCount  = "membersCount"
    static let membersuid  = "membersuid"
    static let adminuid  = "adminuid"
    static let thumbnailUrl  = "thumbnailUrl"
    static let createdBy  = "createdBy"
}

extension ChannelItem {
    
    init(dictionary : [String :Any]) {
        self.id = dictionary[.id] as? String ?? ""
        self.name = dictionary[.name] as? String? ?? ""
        self.lastMessage = dictionary[.lastMessage] as? String ?? ""
        let creationDate = dictionary[.channelCreationDate] as? Double ?? 0
        self.channelCreationDate = Date(timeIntervalSince1970: creationDate)
        let lastMessageTimeStamp = dictionary[.lastMessageTimeStamp] as? Double ?? 0
        self.lastMessageTimeStamp = Date(timeIntervalSince1970 : lastMessageTimeStamp)
        self.members = dictionary[.members] as? [UserItem] ?? []
        self.membersCount = dictionary[.membersCount] as? Int ?? 0
        self.membersuid = dictionary[.membersuid] as? [String] ?? []
        self.adminuid = dictionary[.adminuid] as? [String] ?? []
        self.thumbnailUrl = dictionary[.thumbnailUrl] as? String ?? nil
        self.createdBy = dictionary[.createdBy] as? String ?? ""
       
    }
}
