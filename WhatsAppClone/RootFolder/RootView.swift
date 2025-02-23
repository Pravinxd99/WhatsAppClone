//
//  RootView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 16/02/25.
//

import SwiftUI

struct RootView: View {
    @StateObject var rootViewModel = RootViewModel()
    var body: some View {
       
        switch rootViewModel.authModel {
        case .pending :
            ProgressView()
                .controlSize(.large)
                
        case .loggedIn(let loggedInUser):
            MainTabView(currentUser: loggedInUser)
            
        case .loggedOut :
            LoginScreen()
        }
    }
}

#Preview {
    RootView()
}
