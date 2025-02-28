//
//  AuthProvider.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 15/02/25.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseDatabase


enum DifferentAuthStates {
    case pending , loggedIn (_ currentUser : UserItem), loggedOut
}

enum AuthError {
    case ErrorCreatingUserAccount(errordescription : String)
    case ErrorSavingUserToDb(errordescription : String)
    case ErrorLoggingInTheUser(errordescription : String)
}
extension AuthError : LocalizedError {
   
    var errorMessage: String {
        
        switch self {
        case .ErrorCreatingUserAccount(let errordescription):
            return errordescription
        case .ErrorSavingUserToDb(let errordescription):
            return errordescription
        case .ErrorLoggingInTheUser(let errordescription):
            return errordescription
        }
    }
}

protocol AuthProvider {
    // these are the mandatory functions you need to have inorder to seamlessly perform authentications
    static var singletonAuthProvider : AuthProvider {get}
    var authState : CurrentValueSubject<DifferentAuthStates , Never> {get}
    func createUser (_with email : String , _and password : String , _also username : String) async throws
    func autoLogin() async throws
    func login ( with email : String , and password : String) async throws
    func logOut () async throws
    func  saveUserInfoInDataBase(user : UserItem) async throws
    func fetchCurrentUserInfo ()
}
// manage errors such as creating user failed and saving user to database failed
final class AuthManager : AuthProvider {
    static var singletonAuthProvider:  AuthProvider = AuthManager()
    var authState = CurrentValueSubject<DifferentAuthStates, Never>(.pending)
    private init() {
        Task {
            await autoLogin()
        }
    }
    func createUser(_with email: String, _and password: String, _also username: String) async throws {
        /* invoke the firebase authentication method , create a user object and store in firebase
         store the userinfo in our firestore database
         */
        do{ let userResult = try await Auth.auth().createUser(withEmail: email, password: password) // create user here is a firebase func
            let uid = userResult.user.uid
            let newUser = UserItem(uid: uid, username: username , email: email)
            
            try await saveUserInfoInDataBase(user: newUser)
            self.authState.send(.loggedIn(newUser))
            
        }
        catch {
            print("An error occured while creating the account")
            throw AuthError.ErrorCreatingUserAccount(errordescription: error.localizedDescription)
        }
    }
    
    func saveUserInfoInDataBase(user: UserItem) async throws {
        let userDictionary = ["uid" : user.id , "username" : user.username , "email" : user.email]
        do {
            try await FireBaseConstants.Reference.child(user.id).setValue(userDictionary)
        }// child ("users") is like a folder , child(user.id) is like the key to that respective values think of this like unique value to access and setvalue is the usual way to write values
        // it appears as a tree like struct in realtime db
        /*users ->foler
         uid -> path to the partucular user
         uid
         username
         email*/
        catch {
            print( "Error while saving user to database")
            throw AuthError.ErrorSavingUserToDb(errordescription: error.localizedDescription)
        }
    }
   
    func fetchCurrentUserInfo()  {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        FireBaseConstants.Reference.child(uid).observe(.value) { [weak self] snapshot  in
            
            guard let userDict = snapshot.value as? [String : Any] else {return} // snapshot is nothing but the data received from the user loc
            let loggedInUser = UserItem(dictionary: userDict)
            self?.authState.send(.loggedIn(loggedInUser))
            print("\(loggedInUser.username) has logged in successfully")
        } withCancel: { error in
            print("failed to get current user info")
        }
        
    }
    
    func autoLogin() async  {
        if Auth.auth().currentUser == nil {
            authState.send(.loggedOut)
        }
        else {
            fetchCurrentUserInfo()
        }
    }
    
    // error to be noted the struct with property you created and the dictionary with keys should have the same since you gave different name its validating the uid , name and keys as a previous user but the userdict is not being populated correctly 
    func login(with email: String, and password: String) async throws {
        do {
          let result = try await Auth.auth().signIn(withEmail: email, password: password)
            fetchCurrentUserInfo()
            print("\(String(describing: result.user.email)) has successfully logged in ")
            
        }
        catch {
            print("There is some issue with Logging in \(email)")
            throw AuthError.ErrorCreatingUserAccount(errordescription: error.localizedDescription)
        }
    }
    
    func logOut() async throws {
        do {
            try Auth.auth().signOut()
            authState.send(.loggedOut)
            print("user successfully logged out")
        }
        catch {
            print("failed to log out user")
        }
        
    }
}



