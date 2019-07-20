//
//  LoginVC.swift
//  Thoughts
//
//  Created by Aidan Miskella on 18/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createUserButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 4
        createUserButton.layer.cornerRadius = 4
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let email = emailText.text,
            let password = passwordText.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                
                debugPrint("Error signing in: \(error)")
            } else {
                
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
