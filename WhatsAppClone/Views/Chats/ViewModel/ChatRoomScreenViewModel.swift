//
//  ChatScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 02/08/25.
//

import Foundation
import Combine
import Firebase
final class ChatRoomScreenViewModel : ObservableObject {
    @Published var messages = [MessageItem]()
    @Published var textMessage : String = ""
    private(set) var channel : ChannelItem
    private var currentUser : UserItem?
    var cancellable = Set<AnyCancellable>()
    
    init (channel : ChannelItem)
    {
        self.channel = channel
        listenToAuthStates()
    }
    
    deinit {
        cancellable.forEach{$0.cancel()}
        cancellable.removeAll()
        currentUser = nil
            
        }
          
    
    
    func listenToAuthStates () {
      
         AuthManager.singletonAuthProvider.authState.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] completion in
                switch completion {
                case .loggedIn(let currentUser):
                    self?.currentUser = currentUser
                    self?.fetchAllChannelMembers()
                    print("executed fetch all channel members")
                default :
                    break
                }
            }).store(in: &cancellable)
    }
    
    func sendMessage () {
        guard let currentUser = currentUser else {return}
        MessageServices.sendTextMessage(to: channel, from: currentUser, textMessage: textMessage) { [weak self] in
            self?.textMessage = ""
            print("MessageServices is sending")
            print(self?.textMessage ?? "default message")
        }

    }
    
    func getMessages () {
        MessageServices.getMessagesFromDB(channel: channel) { [weak self] messages in
            self?.messages = messages
            
            print("Messages : \(messages.map{$0.message}), TimeStamp : \(messages.map{$0.timeStamp})")
        }
    }
    
    func fetchAllChannelMembers () {
        var membersUIDs = [String]()
        guard let currentUser = currentUser else {return}
        let channelMembersAlreadyContained = channel.members.compactMap {$0.uid}
       
        if channel.isGroupChat {
             membersUIDs = channel.membersuid.filter{!channelMembersAlreadyContained.contains($0)}
        }
        else if !channel.isGroupChat {
            membersUIDs = channel.membersuid.compactMap {$0}
            
        }
       // temporary fix is done , check later 
        membersUIDs = membersUIDs.filter{$0 != currentUser.id}
        UserServices.getUsers(with: membersUIDs) { [weak self] userNode in
            guard let self = self else {return}
            self.channel.members.append(contentsOf:userNode.users )
            let uniqueChannelMembers = Set(channel.members)
            channel.members = Array(uniqueChannelMembers)
            self.channel.members.append(currentUser)
            self.getMessages()
            print("channel members :\(channel.members.map{$0.username})")
            print("channel members uids:\(channel.membersuid.compactMap{$0})")
        }
        
    }
}

