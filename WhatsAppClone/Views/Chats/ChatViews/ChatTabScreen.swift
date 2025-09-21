//
//  ChatTabScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct ChatTabScreen: View {
    
    @StateObject private var viewModel = ChatTabScreenViewModel()
   
    @State var searchText : String = ""
   
    var body: some View {
        NavigationStack {
            List {
                Archived()
               
                ForEach(viewModel.channels){ channelName in
                    NavigationLink {
                        ChatRoomScreen(channel: channelName)
                    } label: {
                        Chats(channel: channelName)
                           
                    }
                }
                   EncryptionMessage()
                    .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .navigationTitle("Chats")
            .searchable(text: $searchText)
            .toolbar {
                leadingTbItem()
                trailingingTbItem()
            }
            .sheet(isPresented: $viewModel.showChatPartnerPickerView) {
                ChatPartnerPickerScreen(onCreate: viewModel.onChannelCreation)
            }
            .navigationDestination(isPresented: $viewModel.navigateToChatRoom) {
                if let newChannel = viewModel.channelName{
                    ChatRoomScreen(channel: newChannel)
                }
            }
        }
        
        
        
    }
    
        
}
extension ChatTabScreen {
    @ToolbarContentBuilder
    private func leadingTbItem () -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading){
            Menu{
            Button {
            }
                label: {
                    Label("Select Chats" , systemImage: "checkmark.circle")
                }
            }label: {
                Image(systemName: "ellipsis.circle")
            }
            
        }
    }
    @ToolbarContentBuilder
    private func trailingingTbItem () -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing){
            aiButton()
            cameraButton()
            plusButton()
        }
    }
    private func cameraButton () -> some View {
        
            Button {
                
            } label: {
                Image(systemName :"camera")
            }
            
        }
    private func aiButton () -> some View {
        
            Button {
                
            } label: {
                Image(.circle)
            }
            
        }
   
    private func plusButton () -> some View {
        
            Button {
                viewModel.showChatPartnerPickerView = true
                
            } label: {
                Image(.plus)
            }
            
        }
    }


private struct Archived : View {
    var body: some View {
        
        Button {
            
        }label: {
            HStack {
                Image(systemName: "archivebox.fill")
                    .font(.title3)
                    .foregroundStyle(.gray)
                Text("Archived")
                    .bold()
                    .foregroundStyle(.gray)
                    
            }
        }
        .padding()
    }
}

private struct EncryptionMessage : View {
    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
            (
                Text("Your personal messages are")
                +
                Text(" ")
                +
                Text("end-to-end encrypted")
                    .foregroundStyle(.blue)
            )
            .font(.caption)
            .foregroundStyle(.gray)
            
        }
        .padding(.horizontal)
    }
}


#Preview {
    ChatTabScreen()
}
