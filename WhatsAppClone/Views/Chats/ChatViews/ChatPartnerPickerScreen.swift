//
//  ChatPartnerPickerScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 17/02/25.
//

import SwiftUI

struct ChatPartnerPickerScreen: View {
    @StateObject var viewModel = ChatPickerScreenViewModel()
    @Environment(\.dismiss) private var dismiss
    @State var searchText : String = ""
    var onCreate : (_ channelName : ChannelItem) -> ()
    
    var body: some View {
        
        
        NavigationStack (path: $viewModel.navItem) {
            List {
                Section {
                    ForEach(NewStuffSection.allCases) { item in
                        HeaderItemView(item: item)
                        
                            .onTapGesture {
                                
                                switch item {
                                    
                                case .newGroup:
                                    print("Header item tapped: \(item.titleForNewSectionStuff)")
                                    viewModel.navItem.append(.addGroupChatMembers)
                                    print("navItem : \(viewModel.navItem)")
                                case .newContact:
                                    print("Header item tapped: \(item.titleForNewSectionStuff)")
                                    print("navItem : \(viewModel.navItem)")
                                case .newCommunity:
                                    print("Header item tapped: \(item.titleForNewSectionStuff)")
                                    print("navItem : \(viewModel.navItem)")
                                }
                                
                            
                            }
                    }
                }
                Section {
                    ForEach(viewModel.users) { user in
                              ChatPartnerRowView(user: user)
                        
                        
                            .onTapGesture {
                              viewModel.createDirectChannel( chatPartner: user, completion: onCreate)
                            }
                            
                    }
                } header: {
                    Text("Contacts on WhatsApp")
                        .textCase(nil)
                }
                
                if viewModel.isPaginatable{
                    loadMoreUsers()
                }
            }
            .toolbar {
                trailingNavItem()
            }
            
            .onAppear {
                viewModel.deSelectSelectedChatPartners()
            }
            .navigationTitle("New Chat")
            .navigationDestination(for: ChannelCreationRoute.self) { route in
                destinationView(item: route)
            }
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search name or number")
        }
        
    }
    
    private func loadMoreUsers () -> some View {
        
        ProgressView()
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .task {
                await viewModel.fetchUsers() 
            }
    }
}

extension ChatPartnerPickerScreen {
    @ViewBuilder
    private func destinationView(item: ChannelCreationRoute) -> some View {
        switch item {
        case .addGroupChatMembers:
            AddGroupChatPartnerScreen(viewModel: viewModel)
        case .setUpGroupChat:
            NewGroupSetUpScreen(viewModel: viewModel, oncreateGroup: onCreate)
        }
    }

    @ToolbarContentBuilder
    private func trailingNavItem() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                dismiss()
               
            } label: {
                Image(systemName: "xmark")
                    .font(.footnote)
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(8)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
            }
        }
    }
}

extension ChatPartnerPickerScreen {
    private struct HeaderItemView: View {
        var item: NewStuffSection
        
        var body: some View {
            Button {
                // Intentionally left empty
            } label: {
                buttonBody()
            }
        }
        
        private func buttonBody() -> some View {
            HStack {
                Image(systemName: item.picForNewSectionStuff)
                    .font(.footnote)
                    .frame(width: 40, height: 40)
                    .background(Color(.systemGray5))
                    .clipShape(Circle())
                Text(item.titleForNewSectionStuff)
            }
        }
    }
    
}
//extension View {
//    func print(_ value: Any) -> Self {
//        Swift.print(value)
//        return self
//    }
//}

enum NewStuffSection: String, CaseIterable, Identifiable, Hashable {
    var id: String { rawValue }
    
    case newGroup = "New Group"
    case newContact = "New Contact"
    case newCommunity = "New Community"
    
    var titleForNewSectionStuff: String {
        return rawValue
    }
    
    var picForNewSectionStuff: String {
        switch self {
        case .newGroup:
            return "person.2.fill"
        case .newContact:
            return "person.fill"
        case .newCommunity:
            return "person.3.fill"
        }
    }
}

#Preview {
   
    ChatPartnerPickerScreen() {channelName in 
        
    }
    
}

//struct Header : View {
//    var body: some View {
//        ForEach(NewStuffSection.allCases){item in
//            HStack{
//                Image(systemName:item.picForNewSectionStuff)
//                    .background(Color(.green))
//                    .clipShape(Circle())
//                Text(item.titleForNewSectionStuff)
//            }
//        }
//        .padding(5)
//    }
//}
