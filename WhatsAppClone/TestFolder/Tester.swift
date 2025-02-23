//
//  Tester.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 22/02/25.
//

import SwiftUI

struct Tester: View {
    @State var navigitems : [String] = ["praveen", "pravin"]
    var body: some View {
        NavigationStack(path: $navigitems){
            
            List {
                NavigationLink("navitem1") {
                    detailView(navigItems: $navigitems)
                }
                NavigationLink("navitem2") {
                    detailView(navigItems: $navigitems)
                }
            }
        }
        
    }
}

#Preview {
    Tester()
}


struct detailView :  View {
    @Binding var navigItems : [String]
    var body: some View {
        Text("DetailScreen1")
    }
}
    

