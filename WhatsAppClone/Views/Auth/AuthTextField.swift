//
//  AuthTextField.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//

import SwiftUI


struct AuthTextField: View {
    let type : fieldType
    @Binding var text : String
    var body: some View {
        
        HStack {
            Image(systemName: type.image)
                .fontWeight(.semibold)
                .frame(width: 30)
            
            switch type {
            case .password :
                SecureField(type.placeholder, text: $text)
            default:
                TextField(type.placeholder , text: $text)
                    .keyboardType(type.keyBoardType)
            }
           
            
        }
        .foregroundStyle(.white)
        .padding()
        .background(Color.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal , 32)
    }
   
}

extension AuthTextField {
    enum fieldType {
        case custom(placeholder : String , iconname : String) , password , email
        
        
        var placeholder : String {
            switch self {
                
            case .custom(let placeholder ,  _) :
                return placeholder
            case .password:
                return "Password"
            case .email:
                return "Email"
            }
        }
        
        var image : String {
            switch self {
                
            case .custom( _ , iconname: let iconname):
                return iconname
            case .password:
                return "lock"
            case .email:
                return "envelope"
            }
        }
        var keyBoardType : UIKeyboardType {
            switch self {
            case .email:
                return .emailAddress
                
            default :
                return .default
            }
            
        }
    }
}

#Preview {
    ZStack {
        Color.teal
        VStack {
            AuthTextField(type: .password, text: .constant("Password"))
            AuthTextField(type: .email, text: .constant("Email"))
            AuthTextField(type: .custom(placeholder: "Birthday", iconname: "birthday.cake"), text: .constant("Birthday"))
        }
    }
}
