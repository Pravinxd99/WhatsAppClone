//
//  LoginScreen.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject var authViewModel = AuthScreenViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 10){
                Spacer()
                AuthHeaderView()
                AuthTextField(type: .email, text: $authViewModel.email)
                AuthTextField(type: .password, text: $authViewModel.password)
                forgotPasswordButton()
                LoginOrCreateAccountButton( title: "Login now ->"){
                    Task{
                         await authViewModel.handleLogin()
                    }
                }
                .disabled(authViewModel.disableLoginButton)
                .padding(.vertical , -30)
                    
                Spacer()
                signUpButton()
                    .padding(.bottom , 30)
            }
            .frame(maxWidth: .infinity , maxHeight: .infinity)
            .background(Color.teal)
            .ignoresSafeArea()
            .alert(isPresented: $authViewModel.errorState.showerror) {
                Alert(title: Text(authViewModel.errorState.errorMessage), dismissButton: .default(Text("Ok")))
            }
        }
    }
    private func forgotPasswordButton () -> some View {
        Button("Forgot Password? ") {
            
        }
        .font(.title2)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity , alignment: .trailing)
        .padding(.trailing , 32)
        .padding(.vertical,10)
    }
    private func signUpButton () -> some View {
        NavigationLink {
            SignUpScreen(authScreenModel: authViewModel)
        }
        label : {
            HStack{
                Image(systemName: "sparkles")
                    .foregroundStyle(.white)
                (
                Text ("Don't have an account ? Create one")
                    .foregroundStyle(.white)
                )
                Image(systemName: "sparkles")
                    .foregroundStyle(.white)
                }
            }
        }
        
    }


#Preview {
    LoginScreen()
}
