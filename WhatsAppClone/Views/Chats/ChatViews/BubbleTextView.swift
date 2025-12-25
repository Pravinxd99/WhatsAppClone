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
        
        HStack(alignment : .bottom, spacing: 5) {
            if message.showGroupPartnerInfo {
                CircularProfileImageView(profileImage :  message.sender?.profileImage ,size: .mini)
            }
            if message.direction == .sent{
                timeStamp()
            }
            Text(message.message)
                .padding(10)
                .background(message.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 16 , style: .continuous))
                .attachTail(direction: message.direction)
            if message.direction == .received{
                timeStamp()
            }
        }
                    .frame(maxWidth: .infinity , alignment: message.alignment)
                    .padding(.leading , message.leadingPadding)
                    .padding(.trailing , message.trailingPadding)
                
               
            }
            
   private func timeStamp () -> some View {
        
        HStack{
            Text(message.timeStamp.formatToTime  )
                .font(.footnote)
             
        }
    }
}

#Preview {
    ScrollView {
       
        BubbleTextView(message: MessageItem.sentMessageItem)
        BubbleTextView(message: MessageItem.receivedMessageItem)
        BubbleImageView(message: MessageItem.receivedMessageItem)
        BubbleImageView(message: MessageItem.sentMessageItem)
        
    }
    .background(.gray.opacity(0.5))
}
