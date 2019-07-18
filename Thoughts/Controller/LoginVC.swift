//
//  LoginVC.swift
//  Thoughts
//
//  Created by Aidan Miskella on 18/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createUserButton: UIButton!
    
    // Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
        createUserButton.layer.cornerRadius = 10
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        
    }
    
    @IBAction func createUserButtonTapped(_ sender: UIButton) {
        
        
    }
    
}
