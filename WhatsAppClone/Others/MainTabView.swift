//
//  ContentView.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 08/02/25.
//

import SwiftUI

struct MainTabView: View {
    private var currentUser : UserItem
    init ( currentUser : UserItem) {
        self.currentUser = currentUser 
        makeOpaque()
    }
    var body: some View {
        TabView {
            UpdatesTabScreen()
                .tabItem {
                    Text(listOfThings.updates.title)
                    Image(systemName: listOfThings.updates.icons)
                }
            CallTabScreen()
                .tabItem {
                    Text(listOfThings.calls.title)
                    Image(systemName: listOfThings.calls.icons)
                }
            CommunitiesTabScreen()
                .tabItem {
                    Text(listOfThings.communities.title)
                    Image(systemName: listOfThings.communities.icons)
                }
            ChatTabScreen(currentUser)
                .tabItem {
                    Text(listOfThings.chats.title)
                    Image(systemName: listOfThings.chats.icons)
                }
            SettingsTabScreen()
                .tabItem {
                    Text(listOfThings.settings.title)
                    Image(systemName: listOfThings.settings.icons)
                  
                }
            
        }
    }
         func makeOpaque () {
            let appearance = UITabBarAppearance()
             appearance.configureWithOpaqueBackground()
             UITabBar.appearance().standardAppearance = appearance
             UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
extension MainTabView {
    
    enum listOfThings : String  {
        case updates , calls , communities , chats, settings
        
        var title : String {
            return rawValue.capitalized
        }
        
        
        var icons : String {
            switch self {
            case .updates:
                return "circle.dashed.inset.filled"
            case .calls:
                return "phone"
            case .communities:
                return "person.3"
            case .chats:
                return "message"
            case .settings:
                return "gear"
            }
        }
    }
}

#Preview {
    MainTabView(currentUser: sampleUserItem.sampleUserInstance)
}
