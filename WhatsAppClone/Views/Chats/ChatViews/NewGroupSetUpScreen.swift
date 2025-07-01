//
//  GroupSetUpScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 30/06/25.
//

import SwiftUI

struct NewGroupSetUpScreen: View {
    @State var groupName : String = ""
    @ObservedObject var viewModel : ChatPickerScreenViewModel
    var body: some View {
        List {
            
            HStack {
                Circle()
                    .frame(width: 70 , height: 70)
                    .foregroundStyle(Color(.systemGray3))
                    .overlay {
                        Image(systemName: "camera")
                            .imageScale(.large)
                            .frame(width: 100 , height: 50)
                    }
                
                TextField("", text: $groupName , prompt: Text("Group name (optional)") , axis: .vertical)
                
                   
            }
            Section {
                Text ("Disappearing Messages")
                Text("Group Permissions")
            }
            Section {
                
                SelectedChatPartnerView(users: viewModel.selectedChatPartners) { user in
                    
                    viewModel.handleItemSelection(user)
                }
                
            }
            header : {
                    Text("Participants : 12/12")
                }
            .listRowBackground(Color.clear)
            }
        .navigationTitle("New Group")
           
            .toolbar {
                
                trailingItem()
            }
        
        
        }
    
    private func trailingItem () -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                
             
            }label: {
                Text("Next")
                    .bold()
            }
            .disabled(viewModel.selectedChatPartners.isEmpty ? true : false)
        }
    }
    }

    
    

    


#Preview {
    NavigationStack{
        NewGroupSetUpScreen( viewModel: ChatPickerScreenViewModel())
    }
}
