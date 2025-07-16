//
//  ChatTabScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 05/07/25.
//

import Foundation


final class ChatTabScreenViewModel : ObservableObject {
    
    @Published var channelName : ChannelItem?
    
    @Published var navigateToChatRoom : Bool = false
    
    @Published var showChatPartnerPickerView : Bool = false
    
    func onChannelCreation (_ channel : ChannelItem) {
        
        channelName = channel
        navigateToChatRoom = true
        showChatPartnerPickerView = false
    }
}
