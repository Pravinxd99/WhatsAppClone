//
//  MessageListView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import SwiftUI

struct MessageListView: UIViewControllerRepresentable {
    private var viewModel : ChatRoomScreenViewModel
    init(_ viewModel: ChatRoomScreenViewModel) {
        self.viewModel = viewModel
    }
    typealias UIViewControllerType = MessageListViewController
    func makeUIViewController(context: Context) -> MessageListViewController {
        let messageController = MessageListViewController(viewModel)
        return messageController
    }
    
    func updateUIViewController(_ uiViewController: MessageListViewController, context: Context) {
        
    }
   
}

#Preview {
    MessageListView(ChatRoomScreenViewModel(channel: .sampleChannelItem))
}
