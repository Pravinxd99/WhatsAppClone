//
//  AdminMessageTextView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 01/10/25.
//

import SwiftUI

struct AdminMessageTextView: View {
    let channel : ChannelItem
    var body: some View {
        VStack {
            if channel.isCreatedByMe {
                textView(text: "You created this group. Tap to add \n members")
            }
            else {
                textView(text: "\(channel.creatorName) created this group.")
                textView(text: "\(channel.creatorName) added you ")
            }
            
        }
    }
    
    
    private func textView (text : String) -> some View {
        Text(text)
            .font(.footnote)
            .padding(8)
            .frame(width: .infinity)
            .background(.bubbleWhite)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .shadow(color: Color(.systemGray3).opacity(0.3), radius: 5, x: 0,y: 20 )
        
            
    }
}

#Preview {
    AdminMessageTextView(channel: .sampleChannelItem)
}
