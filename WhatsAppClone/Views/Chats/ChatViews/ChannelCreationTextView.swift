//
//  ChannelCreationTextView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 01/10/25.
//

import SwiftUI

struct ChannelCreationTextView: View {
    @Environment(\.colorScheme) private var colorScheme
    private var backGroundColor : Color {
        return colorScheme == .light ? Color.yellow : Color.black
    }
    var body: some View {
        ZStack(alignment: .top) {
            ( Text(Image(systemName: "lock.fill"))
            +
              Text("Messages and calls are end to end encrypted , No one outside of this chat , not even Whatsapp , can read or listen to them")
            +
            Text(" Learn more")
              )
            
        }
        .bold()
        .font(.footnote)
            .padding(10)
            .frame(width: .infinity)
            .background(backGroundColor.opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .padding(.horizontal,30)
    }
}

#Preview {
    ChannelCreationTextView()
}
