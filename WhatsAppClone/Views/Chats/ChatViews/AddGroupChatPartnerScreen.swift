//
//  AddGroupChatPartnerScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 18/02/25.
//

import SwiftUI

struct AddGroupChatPartnerScreen: View {
    @ObservedObject var viewModel : ChatPickerScreenViewModel
    @State var searchText : String = ""
    var body: some View {
       
            List{
                if viewModel.showSelectedUsers {
                    Text("users")
                }
                Section{
                    ForEach([sampleUserItem.sampleUserInstance]){ item in
                        
                        Button {
                            viewModel.handleItemSelection(item)
                        } label:{
                            chatPartnerRowView(user:sampleUserItem.sampleUserInstance) }
                        
                    }
                }
            }
            .animation(.easeInOut, value: viewModel.showSelectedUsers)
            .searchable(text: $searchText ,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search name or number")
        }
    private func chatPartnerRowView (user : UserItem) -> some View {
        
        ChatPartnerRowView(user: sampleUserItem.sampleUserInstance) {
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let backgroundColor = isSelected ? Color.blue : Color(.systemGray5)
                Image(systemName: "circle.fill")
                .foregroundStyle(backgroundColor)
                    .imageScale(.large)
                
            }
        
           
        }
    }
    


#Preview {
    NavigationStack{
        AddGroupChatPartnerScreen(viewModel: ChatPickerScreenViewModel())
    }
}
