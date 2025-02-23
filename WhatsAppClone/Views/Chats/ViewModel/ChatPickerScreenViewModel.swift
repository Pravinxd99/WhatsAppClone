//
//  ChatPickerScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 18/02/25.
//

import Foundation
import SwiftUI

enum ChannelCreationRoute : Hashable{
    
    
    case addGroupChatMembers
    case setUpGroupChat
}
final class ChatPickerScreenViewModel : ObservableObject {
    
    @Published var navItem = [ChannelCreationRoute]()
    @Published var selectedChatPartners = [UserItem]()
    
    var showSelectedUsers : Bool {
        return !selectedChatPartners.isEmpty
    }
    
    func handleItemSelection( _ user : UserItem) {
        if isUserSelected(user) {
            guard let index = selectedChatPartners.firstIndex(where: { alreadySelectedUser in
                alreadySelectedUser.uid == user.uid}) else {return}
            selectedChatPartners.remove(at: index)}
        
        else {
            selectedChatPartners.append(user)
        }
    }
    
    
    func isUserSelected (_ user : UserItem) -> Bool {
        let isSelected = selectedChatPartners.contains { tappedUser  in
            tappedUser.uid == user.uid
        }
        return isSelected
    }
}
