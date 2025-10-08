//
//  ChatScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 02/08/25.
//

import Foundation
import Combine
final class ChatRoomScreenViewModel : ObservableObject {
    @Published var messages = [MessageItem]()
    @Published var textMessage : String = ""
    private(set) var channel : ChannelItem
    private var currentUser : UserItem?
    var cancellable = Set<AnyCancellable>()
    
    init (channel : ChannelItem)
    {
        self.channel = channel
        fetchCurrentUser()
    }
    
    deinit {
        cancellable.forEach{$0.cancel()}
        cancellable.removeAll()
        currentUser = nil
            
        }
          
    
    
    func fetchCurrentUser () {
      
         AuthManager.singletonAuthProvider.authState.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] completion in
                switch completion {
                case .loggedIn(let currentUser):
                    self?.currentUser = currentUser
                    self?.getMessages()
                default :
                    break
                }
            }).store(in: &cancellable)
    }
    
    func sendMessage () {
        guard let currentUser = currentUser else {return}
        MessageServices.sendTextMessage(to: channel, from: currentUser, textMessage: textMessage) { [weak self] in
            self?.textMessage = ""
//            print("MessageServices is sending")
//            print(textMessage)
        }

    }
    
    func getMessages () {
        MessageServices.getMessages(channel: channel) { [weak self] messages in
            self?.messages = messages
            print("Messages : \(messages.map{$0.message})")
        }
    }
}
