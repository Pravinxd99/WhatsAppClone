//
//  BubbleTextView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import SwiftUI

struct BubbleTextView: View {
    var message : MessageItem
    var body: some View {
        
            VStack(alignment : message.horizontalAlignment, spacing: 3) {
                Text(message.message)
                    .font(.callout)
                    .padding(10)
                    .background(message.backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10 , style: .circular))
                    .attachTail(direction: message.direction)
                    .padding(2)
                    .frame(maxWidth: .infinity , alignment: message.alignment)
                    .padding(.leading , message.direction == .sent ? 100 :5)
                    .padding(.trailing , message.direction == .sent ? 5 :100)
                
                timeStamp()
            }
            .padding(.leading)
            .padding(.trailing)
            
        }
    
    
    private func timeStamp () -> some View {
        
        HStack{
            Text("3:05 AM")
                .font(.caption2)
               
            
            if message.direction == .sent {
                Image(.seen)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundStyle(Color(.systemBlue))
            }
             
        }
        .padding(.leading)
        .padding(.trailing)
        
    }
}

#Preview {
    ScrollView {
        BubbleTextView(message: MessageItem.randomtMessageItem)
        BubbleTextView(message: MessageItem.sentMessageItem)
        BubbleTextView(message: MessageItem.receivedMessageItem)
        BubbleImageView(message: .receivedMessageItem)
        BubbleImageView(message: .sentMessageItem)
        BubbleImageView(message: .randomtMessageItem)
    }
    .background(.gray.opacity(0.5))
}
