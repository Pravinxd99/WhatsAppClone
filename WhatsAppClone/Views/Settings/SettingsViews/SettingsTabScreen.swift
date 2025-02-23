//
//  SettingsTabScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct SettingsTabScreen: View {
    @State var searchText : String = ""
    var body: some View {
        NavigationStack {
            List{
                
                Section {
                    ProfileSection()
                    SettingsItemView(item: .avatar)
                }
                Section {
                    SettingsItemView(item: .broadCastLists)
                    SettingsItemView(item: .starredMessages)
                    SettingsItemView(item: .linkedDevices)
                }
                Section {
                    SettingsItemView(item: .account)
                    SettingsItemView(item: .privacy)
                    SettingsItemView(item: .chats)
                    SettingsItemView(item: .notifications)
                    SettingsItemView(item: .storage)
                }
                Section {
                    SettingsItemView(item: .help)
                    SettingsItemView(item: .tellFriend)
                    
                }
            }
            .navigationTitle("Settings")
            .searchable(text: $searchText)
            .toolbar {
                leadingNavBtn()
                trailingBtn()
            }
        }
    }
    
    @ToolbarContentBuilder
    private func trailingBtn () -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing){
            Button {
                
            }label: {
                Text("Save")
                    .bold()
            }
            .bold()
        }
    }
    @ToolbarContentBuilder
    private func leadingNavBtn () -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading){
            Button {
                Task {
                    try?  await AuthManager.singletonAuthProvider.logOut()
                }
            }label: {
                Text("Logout")
                    .bold()
            }
            .bold()
        }
    }
}

private struct ProfileSection : View {
    var body: some View {
        HStack {
            Circle()
                .frame(width: 60 , height: 60)
          (
                Text("Praveen")
                    .bold()
                +
                Text("\n")
                +
                Text("Hey there! I am using WhatsApp")
                    .font(.custom("Hey there! I am using WhatsApp", size: 15))
                    .foregroundStyle(.gray)
            )
            
            
            Spacer()
            
            Image(.qrcode)
                .renderingMode(.template)
                .padding(4)
                .foregroundStyle(.blue)
                .background(Color(.systemGray5))
                .clipShape(Circle())
                
                
        }
    }
}
    


#Preview {
    SettingsTabScreen()
}
