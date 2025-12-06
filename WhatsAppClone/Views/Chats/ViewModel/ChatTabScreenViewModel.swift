//
//  ChatTabScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 05/07/25.
//

import Foundation
import Firebase
import FirebaseAuth

enum ChatTabRoute : Hashable {
    case channelRoute( channel : ChannelItem)
}
final class ChatTabScreenViewModel : ObservableObject {
    
    @Published var channelName : ChannelItem?
    @Published var navRoutes : [ChatTabRoute] = []
    @Published var navigateToChatRoom : Bool = false
    
    @Published var showChatPartnerPickerView : Bool = false
    
    @Published var channels = [ChannelItem]()
    
    typealias ChannelId = String
    @Published var channelDictionary : [ChannelId : ChannelItem] = [:]
    
    func onChannelCreation (_ channel : ChannelItem) {
        
        channelName = channel
        navigateToChatRoom = true
        showChatPartnerPickerView = false
    }
    
    init() {
        
        getCurrentUsersChannels() 
    }
    
    func getCurrentUsersChannels () {
        
        guard let currentUserUid = Auth.auth().currentUser?.uid else {return}
        
        FireBaseConstants.UserchannelReference.child(currentUserUid).observe(.value) {[weak self] snapshot in
            
            guard let dict = snapshot.value as? [String:Any] else {return}
            
            dict.forEach { key , value in
                let channelId = key
                
                self?.getChannel(channelId)
            }
            }
            
         withCancel: { error in
            print("Failed to get current users channelsId's \(error.localizedDescription)")
        }
            
        }
    
    func getChannel ( _ channelId : String)  {
        
        FireBaseConstants.ChannelsReference.child(channelId).observe(.value) { [weak self]  snapshot, _  in
            guard  let channelDictionary = snapshot.value as? [String : Any] else {return}
            var channel = ChannelItem(dictionary: channelDictionary)
            self?.getChannelMembers(channel: channel) { members in
                channel.members = members
                self?.channelDictionary[channelId] = channel
                self?.reloadData()
                print("CHANNEL NAME : \(channel.title)")
            }
           
        } withCancel: { error in
            print("Failed to get channels for id \(channelId)  \(error.localizedDescription)")
        }

    }
    
    func getChannelMembers (channel : ChannelItem  , completion : @escaping (_ members : [UserItem]) -> Void) {
        
        guard let currentUserUid = Auth.auth().currentUser?.uid else {return}
        let channelMembersUid = Array(channel.membersuid.filter{ $0 != currentUserUid}.prefix(2))
        UserServices.getUsers(with: channelMembersUid) { userNode in
            completion(userNode.users)
        }
        
    }
    
    
    private func reloadData() {
        
        self.channels = Array(channelDictionary.values)
        self.channels = channels.sorted(by: {$0.lastMessageTimeStamp > $1.lastMessageTimeStamp  })
        
    }
        
    
}
