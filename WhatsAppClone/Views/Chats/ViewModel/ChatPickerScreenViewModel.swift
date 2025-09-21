//
//  ChatPickerScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 18/02/25.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth

enum ChannelCreationRoute : Hashable{
    
    
    case addGroupChatMembers
    case setUpGroupChat
}

enum maxChannelParticipants {
    static let maxCount = 12
}

enum CustomError : Error{
    
    case noUsers
    case failedToCreateUniqueIds
    
}


@MainActor
final class ChatPickerScreenViewModel : ObservableObject {
    
    @Published var navItem = [ChannelCreationRoute]()
    @Published var selectedChatPartners = [UserItem]()
    @Published var users : [UserItem ] = []
    @Published var alertError : (errorMessageForUser : String , errorState : Bool) = ("" , false)
    
    private var lastCursor : String?
    
    var showSelectedUsers : Bool {
        return !selectedChatPartners.isEmpty
        
    }
    var isDirectChannel : Bool {
        selectedChatPartners.count == 1
    }
    
    
    init() {
        
        Task {
            await fetchUsers()
        }
    }
    func fetchUsers () async    {
        do {
            
            let userNode =  try await UserServices.paginateUsers(lastCursor: lastCursor, pageSize: 5)
            let currentUser = Auth.auth().currentUser?.uid ?? ""
            let excludedCurrentUser = userNode.users.filter { value in
                value.uid != currentUser
            }
            users.append(contentsOf: excludedCurrentUser)
            self.lastCursor = userNode.currentCursor
            print("\(lastCursor)" , "\(users.count)")
            print("\(userNode.currentCursor)")
               
        }
        catch {
            print("Failed to fetch data from ChatPickerScreenViewModel")
        }
    }
    
    func errorMessages (message : String) {
        
        alertError.errorMessageForUser = message
        alertError.errorState = true
    }
    
    func handleItemSelection( _ user : UserItem) {
        if isUserSelected(user) {
            guard let index = selectedChatPartners.firstIndex(where: { alreadySelectedUser in
                alreadySelectedUser.uid == user.uid}) else {return}
            selectedChatPartners.remove(at: index)}
        
        else {
            guard selectedChatPartners.count < maxChannelParticipants.maxCount else {
                errorMessages(message: "max participants already reached")
                print("max participants already reached ")
                return
            }
            selectedChatPartners.append(user)
        }
    }
    
    var isSelectedPrtnerAvailable : Bool {
        let status = !selectedChatPartners.isEmpty ? true : false
        return status
    }
    
    
    func isUserSelected (_ user : UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains { tappedUser  in
            tappedUser.uid == user.uid
        }
        return isSelected
    }
    
    var isPaginatable : Bool {
        return !users.isEmpty 
            
    }
    
    func deSelectSelectedChatPartners() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.selectedChatPartners.removeAll()
        }
    }
    
    func createDirectChannel ( chatPartner :UserItem, completion : @escaping (_ newChannel : ChannelItem) -> Void ){
        selectedChatPartners.append(chatPartner)
        
        Task {
            if let channelId =  await verifyIfAlreadyChannelExists(charPartnerId: chatPartner.uid) ,
               let snapshot = try? await FireBaseConstants.ChannelsReference.child(channelId).getData(),
               var channelDict = snapshot.value as? [String:Any] {
                var directChannel = ChannelItem(dictionary: channelDict)
                directChannel.members = selectedChatPartners
                completion(directChannel)
                
                
            }
            else {
                
                let channelCreation = createChannel(channelName: nil)
                
                switch channelCreation {
                case .success(let channel):
                    completion(channel)
                case .failure(let error):
                    errorMessages(message: "Something went wrong failed to create a new direct chat")
                    print("Error : \(error.localizedDescription)" )
                }
            }
        }
    }
    func createGroupChannel (groupName : String? , completion : @escaping (_ newChannel : ChannelItem) -> Void ){
        
        let channelCreation = createChannel(channelName: groupName)
        
        switch channelCreation {
        case .success(let channel):
            completion(channel)
        case .failure(let error):
            errorMessages(message: "uh oh Something went wrong failed to create a new group chat")
            print("Error :  \(error.localizedDescription)")
        }
    }
    
    typealias channelId = String
    private func verifyIfAlreadyChannelExists ( charPartnerId : String) async -> channelId? {
        
        guard let currentUserUid = Auth.auth().currentUser?.uid  ,
        
                let snapshot = try?  await FireBaseConstants.UserdirectChannels.child(currentUserUid).child(charPartnerId).getData(),
                snapshot.exists() else { return nil}
        snapshot.exists()
        let channelDict = snapshot.value as! [String : Bool]
        let channelId = channelDict.compactMap{$0.key}.first
        
        return channelId
        
        
    }
    
    private func createChannel (channelName : String?)  -> Result<ChannelItem,Error> {
       
        guard !selectedChatPartners.isEmpty else {
            return .failure(CustomError.noUsers)
        }
        //return .failure(CustomError.noUsers)
       
        guard let currentUserUid = Auth.auth().currentUser?.uid,
              let channelId = FireBaseConstants.ChannelsReference.childByAutoId().key ,
              let messageId = FireBaseConstants.MessagesReference.childByAutoId().key
              else {
            return .failure(CustomError.failedToCreateUniqueIds)}
        
        
        
        let timestamp = Date().timeIntervalSince1970
        var memberUids = selectedChatPartners.compactMap { $0.uid}
        let newChannelBroadCast = AdminMessageType.channelCreation.rawValue
        
        memberUids.append(currentUserUid)
        
        var channelDict : [String : Any] = [
            
          
            .id : channelId,
            .membersCount : memberUids.count,
            .membersuid : memberUids,
            .lastMessageTimeStamp : timestamp,
            .lastMessage : newChannelBroadCast,
            .adminuid : [currentUserUid],
            .channelCreationDate : timestamp,
            
            
        ]
        
        if let channelName = channelName , !channelName.isEmptyOrWhiteSpaces {
            channelDict[.name] = channelName
        }
        
        let messageDict : [String : Any] = [.type : newChannelBroadCast , .creationTime : timestamp , .owneruid : currentUserUid]
            
            
        
        FireBaseConstants.ChannelsReference.child(channelId).setValue(channelDict)
        FireBaseConstants.MessagesReference.child(channelId).child(messageId).setValue(messageDict)
       
        
        memberUids.forEach { userId   in
            FireBaseConstants.UserchannelReference.child(userId).child(channelId).setValue(true)
           
        }
        
        if isDirectChannel {
            let chatPartner = selectedChatPartners[0]
            FireBaseConstants.UserdirectChannels.child(currentUserUid).child(chatPartner.uid).setValue([channelId: true])
            FireBaseConstants.UserdirectChannels.child(chatPartner.uid).child(currentUserUid).setValue([channelId:true ])
        }
        
        
        var newChannelItem = ChannelItem(dictionary: channelDict)
        newChannelItem.members = selectedChatPartners
        
        return .success(newChannelItem)
                                                       
     }
}
