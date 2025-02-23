//
//  AuthScreenViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//


import Foundation

@MainActor
class AuthScreenViewModel : ObservableObject {
    
    @Published var userName : String = ""
    @Published var password : String = ""
    @Published var email : String = ""
    @Published var isLoading : Bool = false
    @Published var errorState : (showerror :Bool , errorMessage: String) = (false , "Oh No")
    
    var disableSignupButton : Bool {
        return userName.isEmpty || password.isEmpty || email.isEmpty || isLoading 
        }
    var disableLoginButton : Bool {
            return password.isEmpty || email.isEmpty || isLoading
        }
    
    func handleLogin() async  {
        
        do {
            isLoading = true
            try await AuthManager.singletonAuthProvider.login(with: email, and: password)
        }
        catch {
            errorState.errorMessage = "Error while logging in the user \(error.localizedDescription)"
            errorState.showerror = true
            isLoading = false
        }
    }
    func handleSignUp () async {
        do {
            isLoading = true
            try await AuthManager.singletonAuthProvider.createUser(_with: email, _and: password, _also: userName)
        }
        catch {
            errorState.showerror = true
            errorState.errorMessage = "Error while creating an account \(error.localizedDescription)"
            isLoading = false
        }
    }
}
