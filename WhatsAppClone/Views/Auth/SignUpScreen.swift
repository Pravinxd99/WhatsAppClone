//
//  SignUpScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//

import SwiftUI

struct SignUpScreen: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var authScreenModel : AuthScreenViewModel
    var body: some View {
        VStack {
            Spacer()
            AuthHeaderView()
            AuthTextField(type: AuthTextField.fieldType.email, text: $authScreenModel.email)
            AuthTextField(type: AuthTextField.fieldType.custom(placeholder: "Username", iconname: "at"), text: $authScreenModel.userName)
            AuthTextField(type: AuthTextField.fieldType.password, text: $authScreenModel.password)
            LoginOrCreateAccountButton(title: "Create an Account ->", onTap: {
                
                Task {
                     await authScreenModel.handleSignUp()
                }
            })
            .disabled(authScreenModel.disableSignupButton)
            .padding(.vertical , -5)
            Spacer()
            signUpButton()
                .padding(.bottom , 30)
        }
        .frame(maxWidth: .infinity , maxHeight: .infinity)
        .background{
            LinearGradient(colors: [.green , .green.opacity(0.8) , .teal] , startPoint : .top , endPoint : .bottom)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .alert(isPresented: $authScreenModel.errorState.showerror) {
            Alert(title: Text(authScreenModel.errorState.errorMessage), dismissButton: .default(Text("Ok")))
        }
}
    private func signUpButton () -> some View {
        Button {
            dismiss()
        }
        label : {
            HStack{
                Image(systemName: "sparkles")
                    .foregroundStyle(.white)
                (
                    Text ("Already have an account ? Log in ")
                        .foregroundStyle(.white)
                )
                Image(systemName: "sparkles")
                    .foregroundStyle(.white)
            }
        }
        
    }
}

#Preview {
    SignUpScreen(authScreenModel: AuthScreenViewModel())
}
