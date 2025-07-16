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
                    ForEach(viewModel.users){ user in
                        
                        Button {
                            viewModel.handleItemSelection(user )
                        } label:{
                            chatPartnerRowView(user:user ) }
                        
                    }
                }
                
                if viewModel.isPaginatable {
                    loadMoreUsers()
                }
            }
        
            .alert(isPresented: $viewModel.alertError.errorState) {
                Alert(title: Text("Error"),message: Text(viewModel.alertError.errorMessageForUser), dismissButton: .default(Text("Ok")))
                
            }
            .toolbar {
                addParticipantsItem()
                trailingNavButton()
            }
            .animation(.easeInOut, value: viewModel.showSelectedUsers)
            .searchable(text: $searchText ,placement: .navigationBarDrawer(displayMode: .always), prompt: "Search name or number")
        }
    
    private func loadMoreUsers () -> some View {
        ProgressView()
            .frame(maxWidth: .infinity)
            .task {
                await viewModel.fetchUsers()
            }
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
                
                viewModel.navItem.append(.setUpGroupChat)
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



