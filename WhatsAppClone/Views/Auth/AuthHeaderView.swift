//
//  AuthHeaderView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//

import SwiftUI

struct AuthHeaderView: View {
    var body: some View {
        HStack {
            Image(.whatsapp)
                .resizable()
                .frame(width: 40 , height: 40)
            Text("WhatsApp")
                .foregroundStyle(.white)
                .font(.largeTitle)
            .fontWeight(.semibold)        }
        
    }
}

#Preview {
    AuthHeaderView()
        .background(.gray.opacity(0.5))
}
