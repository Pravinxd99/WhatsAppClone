//
//  ChatPartnerRowView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 18/02/25.
//

import SwiftUI

struct ChatPartnerRowView<Content : View>: View {
   private  let user : UserItem
    private let trailingNavItem : Content
    
    init(user: UserItem, @ViewBuilder trailingNavItem: () -> Content =  {EmptyView() // whenever i'm instantiating my chatpartnerview i'm passing my own customised view as well as i wish 
    }) {
        self.user = user
        self.trailingNavItem = trailingNavItem()
    }
    var body: some View {
        HStack {
            CircularProfileImageView(profileImage: user.profileImage, size: .xsmall)
            VStack (alignment: .leading){
                Text(user.username)
                    .bold()
                    .foregroundStyle(.whatsAppBlack)
                Text(user.bioUnwrapped)
                    .font(.caption)
                    .foregroundStyle(.gray)
                
                
            }
            trailingNavItem
        }
    }
}

#Preview {
    
    ChatPartnerRowView(user: sampleUserItem.sampleUserInstance){
        Button() {
            
        }label : {
            Image(systemName: "xmark")
        }
    }
}
