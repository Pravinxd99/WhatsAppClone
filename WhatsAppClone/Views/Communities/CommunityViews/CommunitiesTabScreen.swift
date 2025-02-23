//
//  CommunitiesTabScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct CommunitiesTabScreen: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10 ){
                    Image(.communities)
                    
                    Group {
                        Text("Stay connected with a community")
                            .font(.title2)
                            .bold()
                           
                        Text("Communities bring members together in topic - based groups.Any community you're added to will appear here.")
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.leading)
                        
                        Button("See example communities>") {
                            
                        }
                        .font(.title3)
                        .frame(maxWidth: .infinity)
                        .bold()
                        
                    }
                    
                    NewCommunityButton()
                }.padding(.all)
                .navigationTitle("Communities")
            }
        }
    }
}

private struct NewCommunityButton : View {
    var body: some View {
        Button(" +  New Community") {
            
        }
        .bold()
        .frame(width: 350 , height: 40 , alignment: .center)
        .foregroundStyle(.white)
        .background(.blue)
        .clipShape(.buttonBorder)
        .padding(.vertical)
        .padding(.leading , 12)
        
    }
       
}

#Preview {
    CommunitiesTabScreen()
}
