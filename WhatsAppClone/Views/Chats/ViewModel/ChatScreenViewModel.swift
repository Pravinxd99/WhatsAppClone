//
//  ChatScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 02/08/25.
//

import Foundation

final class ChatScreenViewModel : ObservableObject {
    
    @Published var textMessage : String = ""
    
    //@Published var gotSomethingFromClosure : String?
    
    
    func sendMessage () {
        
//        gotSomethingFromClosure = param
//        print(gotSomethingFromClosure!)
        print("textmessage : \(textMessage)")
    }
}
