//
//  SelectedChatPartnerView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 23/02/25.
//

import SwiftUI

struct SelectedChatPartnerView: View {
    
    var users : [UserItem]
    var closure : (_ user : UserItem) -> Void
    var body: some View {
        ScrollView(.horizontal , showsIndicators: false) {
            HStack{
                
                ForEach (users) { item in
                    
                    chatPartnerView(item)
                }
                
            }
        }
    }
        
        private func chatPartnerView (_ user : UserItem) -> some View {
            VStack {
                Circle()
                    .fill(.gray)
                    .frame(width: 60 , height: 60)
                    .overlay(alignment: .topTrailing) {
                        cancelButton(user: user)
                    }
                Text(user.username)
            }
        }
        
        private func cancelButton ( user : UserItem) -> some View {
            
            Button {
                closure(user)
                
            }label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10 ,height: 10)
                    .padding(5)
                    .foregroundStyle(Color(.systemGray))
                    .background(Color(.systemGray6))
                    .clipShape(Circle())
            }
            
        }
    
}

#Preview {
    SelectedChatPartnerView(users: sampleUserItem.sampleUserInstances)
    {user in
        
    }
}
