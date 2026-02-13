//
//  ChatRoomScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import SwiftUI


struct ChatRoomScreen: View {
    
    @StateObject var viewModel : ChatRoomScreenViewModel
    var channel : ChannelItem
    
    init( channel: ChannelItem) {
        self.channel = channel
        _viewModel = StateObject(wrappedValue: ChatRoomScreenViewModel(channel: channel))}
    var body: some View {
        MessageListView(viewModel)
        .safeAreaInset(edge: .bottom) {
            bottomSafeAreaView()
        }
        .photosPicker(isPresented: $viewModel.showPhotoPicker, selection: $viewModel.photoPickerItems,maxSelectionCount: 5)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            leadingButton()
            trailingButton()
        }
        .toolbarVisibility(.hidden, for: .tabBar)
    }
    private func bottomSafeAreaView () -> some View {
        VStack(spacing: 0) {
            if viewModel.showPhotoPickerPreview {
                Divider()
                MediaAttachmentPreview(mediaAttachment: viewModel.mediaAttchments)
                Divider()
            }
            TextInputArea(enteredText: $viewModel.textMessage) {tappedItem in 
                viewModel.redirectToCorrectAction(action: tappedItem)
            }
        }
    }
    @ToolbarContentBuilder
    private func trailingButton () -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            Button {
                
            }
            
            label: {
                Image(systemName: "video")
                    .padding(10)
                Image(systemName: "phone")
                    .padding(10)
            }
            .bold()
        }
    }
    @ToolbarContentBuilder
    private func leadingButton () -> some ToolbarContent {
        var channenTitle : String {
            let maxChars = 18
            let title = channel.title.count > maxChars ? "..." : ""
            let finalTitle = channel.title.prefix(15) + title
            return String(finalTitle)
        }
        ToolbarItemGroup(placement: .topBarLeading) {
            Button {
                
            }
            label: {
                HStack{
                    Circle()
                        .frame(width: 40 , height: 35)
                    Text(channenTitle)
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
