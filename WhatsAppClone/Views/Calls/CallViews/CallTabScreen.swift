//
//  CallTabScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct CallTabScreen: View {
    @State var searchText : String = ""
    @State var selectionType = selectionPicker.all
    var body: some View {
        NavigationStack {
            VStack{
                List{
                    CreateCallLinkHeader()
                    
                    Section {
                        CallHistory()
                    }header: {
                        Text("Recent")
                    }
                    
                }
            }
            .navigationTitle("Calls")
            .searchable(text: $searchText)
            .toolbar {
                leadingNavItem()
                trailingNavItem()
                principalNavItem()
            }
        }
    }
    @ToolbarContentBuilder
    private func leadingNavItem () -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading){
            Button("Edit") {
                
            }
        }
    }
    @ToolbarContentBuilder
    private func trailingNavItem () -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing){
            Button {
                
            }
            label: {
                Image(systemName:"phone.arrow.up.right")
                    .foregroundStyle(.black)
            }
        }
    }
    @ToolbarContentBuilder
    private func principalNavItem () -> some ToolbarContent {
        ToolbarItem(placement: .principal){
            Picker("Picker", selection: $selectionType ) {
                ForEach(selectionPicker.allCases) { item in
                    Text(item.rawValue.capitalized)
                        .tag(item)
                }
            }
            .pickerStyle(.segmented)
            .frame(width: 150)
                
            
        }
        
    }
    enum selectionPicker : String , Identifiable,CaseIterable {
        
        case all , missed
        
        var id : String {
            rawValue.capitalized
        }
    }
}
private struct CreateCallLinkHeader : View {
    var body: some View {
        
        HStack {
            Image(systemName: "link")
                .padding(6)
                .font(.title2)
                .background(Color(.systemGray5))
                .foregroundStyle(.blue.opacity(0.8))
                .clipShape(Circle())
               
                
            VStack(alignment: .leading){
                Text("Create Call Link")
                    .bold()
                    .foregroundStyle(.blue.opacity(0.8))
                Text("Share a link for your Whatsapp call")
                    .foregroundStyle(.gray)
            }
            
        }
    }
}

private struct CallHistory : View {
    var body: some View {
        
        VStack{
            
            ForEach(0..<15) { _ in
                HStack{
                    Circle()
                        .frame(width: 50 , height: 50)
                    
                    VStack(alignment:.leading) {
                        Text("John Smith")
                            .bold()
                        HStack{
                            Image(systemName: "phone.arrow.up.right")
                                .foregroundStyle(.gray)
                            
                            Text("Outgoing")
                                .foregroundStyle(.gray)
                        }
                    }
                    Spacer()
                    Text("Yesterday")
                    Image(systemName: "info.circle")
                        .font(.title2)
                }
            }
        }
}
}

#Preview {
    CallTabScreen()
}
