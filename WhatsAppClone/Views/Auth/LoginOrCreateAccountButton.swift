//
//  LoginOrCreateAccountButton.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//

import SwiftUI

struct LoginOrCreateAccountButton: View {
    @Environment(\.isEnabled) private var isEnabled
    //var text : EnumType
    var title : String = "Login ->"
    var onTap :() -> Void
    var backgroundColor : Color {
         isEnabled ? Color.white : Color.white.opacity(0.3)
    }
    var textColor : Color {
        isEnabled ? Color.green : Color.white
    }
    var body: some View {
       
        Button(title) {
            onTap()
        }
        .font(.headline)
        .foregroundStyle(textColor)
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(30)
    }
}

#Preview {
    ZStack{
        Color.teal
        VStack{
            LoginOrCreateAccountButton(title: "Login ->", onTap: {
                
            })
            LoginOrCreateAccountButton (title: "Create an account ->", onTap: {
                
            })
          
        }
    }
}

//    extension LoginOrCreateAccountButton {
//        enum EnumType  {
//            case login , createAccounnt
//            
//            var title : String {
//                switch self {
//                    
//                case .login:
//                    return "Login ->"
//                case .createAccounnt:
//                    return "Create an Account ->"
//                }
//            }
//        }
//    }
