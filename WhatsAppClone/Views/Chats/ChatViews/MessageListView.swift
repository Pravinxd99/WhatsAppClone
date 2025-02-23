//
//  MessageListView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import SwiftUI

struct MessageListView: UIViewControllerRepresentable {
    typealias UIViewControllerType = MessageListViewController
    func makeUIViewController(context: Context) -> MessageListViewController {
        let messageController = MessageListViewController()
        return messageController
    }
    
    func updateUIViewController(_ uiViewController: MessageListViewController, context: Context) {
        
    }
   
}

#Preview {
    MessageListView()
}
