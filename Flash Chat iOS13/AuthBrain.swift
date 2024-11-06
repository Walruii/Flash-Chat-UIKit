//
//  AuthBrain.swift
//  Flash Chat iOS13
//
//  Created by Inderpreet Bhatti on 03/11/24.
//  Copyright © 2024 Inderpreet Bhatti. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

protocol AuthBrainDelegate {
    func didLogout(_ authBrain: AuthBrain);
}

struct AuthBrain {
    
    var delegate : AuthBrainDelegate?
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.delegate?.didLogout(self)
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
}
