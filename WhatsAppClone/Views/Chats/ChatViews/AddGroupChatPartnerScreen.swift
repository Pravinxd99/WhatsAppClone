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
                    SelectedChatPartnerView(users: viewModel.selectedChatPartners){user in 
                        viewModel.handleItemSelection(user)
                    }
                }
                
                
                Section{
                    ForEach(sampleUserItem.sampleUserInstances){ item in
                        
                        Button {
                            viewModel.handleItemSelection(item)
                        } label:{
                            chatPartnerRowView(user:item ) }
                        
                    }
                }
            }
            .toolbar {
                addParticipantsItem()
                trailingNavButton()
            }
            .animation(.easeInOut, value: viewModel.showSelectedUsers)
            .searchable(text: $searchText ,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search name or number")
        }
    private func chatPartnerRowView (user : UserItem) -> some View {
        
        ChatPartnerRowView(user: user) {
            Spacer()
            let isSelected = viewModel.isUserSelected(user)
            let image = isSelected ? "checkmark.circle.fill" : "circle.fill"
            let backgroundColor = isSelected ? Color.blue : Color(.systemGray5)
            Image(systemName: image)
                .foregroundStyle(backgroundColor)
                    .imageScale(.large)
                
            }
        
           
        }
    }
    
extension AddGroupChatPartnerScreen {
    
    @ToolbarContentBuilder
    private func addParticipantsItem () -> some ToolbarContent {
        ToolbarItem(placement: .principal) {
            VStack {
                Text("Add Participants")
                    .bold()
                let count = viewModel.selectedChatPartners.count
                let maxCount = maxChannelParticipants.maxCount
                Text("\(count)/\(maxCount)")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
        }
    }
    private func trailingNavButton () -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Next"){
                
            }
            .bold()
            .disabled(!viewModel.isSelectedPrtnerAvailable)
        }
    }
    
}
#Preview {
    NavigationStack{
        AddGroupChatPartnerScreen(viewModel: ChatPickerScreenViewModel())
    }
}



