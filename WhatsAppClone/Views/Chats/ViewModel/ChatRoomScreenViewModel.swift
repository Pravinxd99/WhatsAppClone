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
                guard let self = self else {return}
                switch completion {
                case .loggedIn(let currentUser):
                    self.currentUser = currentUser
                    if self.channel.allMembersFetched {
                        getMessages()
                    }else{
                        self.fetchAllChannelMembers()
                    }
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
        
        guard let currentUser = currentUser else {return}
        let channelMembersAlreadyContained = channel.members.compactMap {$0.uid}
        var membersUIDs = channel.membersuid.filter{!channelMembersAlreadyContained.contains($0)}
        membersUIDs = membersUIDs.filter{$0 != currentUser.id}
        UserServices.getUsers(with: membersUIDs) { [weak self] userNode in
            guard let self = self else {return}
            self.channel.members.append(contentsOf:userNode.users )
            self.getMessages()
            print("channel members :\(channel.members.map{$0.username})")
            print("channel members uids:\(channel.membersuid.compactMap{$0})")
        }
        
    }
}

