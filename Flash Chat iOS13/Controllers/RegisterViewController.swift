//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Inderpreet Bhatti on 01/11/24.
//  Copyright © 2024 Inderpreet Bhatti. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error {
                   print("Error: \(error.localizedDescription)")
                } else {
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
    
}
