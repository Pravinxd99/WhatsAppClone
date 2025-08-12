//
//  ChatRoomScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import SwiftUI

struct ChatRoomScreen: View {
    
    @StateObject var viewModel = ChatScreenViewModel()
    var channel : ChannelItem
    var body: some View {
        MessageListView()
        .safeAreaInset(edge: .bottom) {
            TextInputArea(enteredText: $viewModel.textMessage) { 
                viewModel.sendMessage()
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            leadingButton()
            trailingButton()
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
    @ToolbarContentBuilder
    private func trailingButton () -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                
            }
            label: {
                Image(systemName: "video")
                    .padding()
                Image(systemName: "phone")
            }
            .bold()
        }
    }
    private func leadingButton () -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarLeading) {
            Button {
                
            }
            label: {
                HStack{
                    Circle()
                        .frame(width: 40 , height: 35)
                    Text(channel.title)
                        .bold()
                }
            }
        }
    }
}

#Preview {
    NavigationStack{
        ChatRoomScreen(channel: .sampleChannelItem)
    }
    
}
