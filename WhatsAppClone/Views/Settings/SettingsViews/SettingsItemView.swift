//
//  SettingsItemView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import SwiftUI

struct SettingsItemView: View {
    let item : SettingsItem
    var body: some View {
        HStack {
                 iconImageView()
                .padding(3)
                .foregroundStyle(.white)
                .background(item.backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
            
            Text(item.title)
                .font(.system(size: 18))
            Spacer()
        }
    }
    
    @ViewBuilder
    private func iconImageView () -> some View {
        switch item.imageType {
        case .assetImage:
            Image(item.imageName)
                .bold()
                .font(.callout)
        case .systemImage:
            Image(systemName: item.imageName)
                .renderingMode(.template )
                .padding(3)
        }
    }
}

#Preview {
    SettingsItemView(item: .avatar)
}
