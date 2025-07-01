//
//  RootViewModel.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 16/02/25.
//

import Foundation
import Combine


    

final class RootViewModel : ObservableObject {
    @Published private(set)var authModel = DifferentAuthStates.pending
    private var cancellable : AnyCancellable?
    
    init() {
        cancellable =  AuthManager.singletonAuthProvider.authState.receive(on: DispatchQueue.main) // publisher gets its updated from authstate.send from authmanager
        // sink is the subscription
            .sink {[weak self] latestAuthUser in
                self?.authModel = latestAuthUser
            }
        
        
    }
    
}
/* notes :
 cancellable is used to store the subscription
 if cancellable is not there the closure get executed and gets deallocated rightaway since nobody is listening to it
 */
