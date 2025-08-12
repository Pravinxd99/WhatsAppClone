//
//  SwiftUIView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct Chats: View {
    
    var channel : ChannelItem
    var body: some View {
        HStack (alignment: .top, spacing: 9){
            Circle()
                .frame(width: 60 , height: 60)
            
            
            VStack(alignment: .leading, spacing: 5) {
                titleTextView()
                lastMessagePreview()
                 
            }
           
        
        }
    }
    
    private func titleTextView () -> some View {
        HStack(alignment: .bottom , spacing: 10){
            Text(channel.title)
                .lineLimit(1)
                .bold()
               
            Spacer()
            Text("5.50PM")
                .font(.system(size: 15))
                .foregroundStyle(.gray)
        }
    }
        
        private func lastMessagePreview () -> some View {
            Text(channel.lastMessage)
                .font(.system(size: 16))
                .foregroundStyle(.gray)
                
        }
        
    }


#Preview {
    Chats(channel: .sampleChannelItem)
}
