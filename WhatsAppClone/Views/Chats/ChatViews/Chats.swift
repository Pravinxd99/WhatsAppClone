//
//  SwiftUIView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct Chats: View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 80 , height: 80)
            
            VStack(alignment: .leading ){
                Text("Username")
                    .bold()
                    .font(.title3)
                Text("Hey welcome")
                    .foregroundStyle(.gray)
            }
            Spacer()
            Text("5:50 PM")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    Chats()
}
