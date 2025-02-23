//
//  Helper.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 09/02/25.
//

import Foundation
import SwiftUI

private struct BubbleTailModifier : ViewModifier {
    var direction : MessageDirection
    
    
    func body(content : Content) -> some View {
        content.overlay( alignment: direction == .received ? .bottomLeading : .bottomTrailing){
            BubbleTailView(direction: direction)
        }
       
    }
}

extension View {
    
    func attachTail(direction : MessageDirection) -> some View {
        self.modifier(BubbleTailModifier(direction: direction))
    }
    
}

