//
//  CreateUserVC.swift
//  Thoughts
//
//  Created by Aidan Miskella on 18/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

class CreateUserVC: UIViewController {

    // Outlets
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var createUserButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // Variables
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUserButton.layer.cornerRadius = 4
        cancelButton.layer.cornerRadius = 4
    }
    
    @IBAction func createUserButtonTapped(_ sender: UIButton) {
        
        guard let email = emailText.text,
            let password = passwordText.text,
            let username = usernameText.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                
                debugPrint("Error creating user: \(error.localizedDescription)")
            } else {
                
                let changeRequest = CURRENT_USER?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    if let error = error {
                        
                        debugPrint("Error display name: \(error.localizedDescription)")
                    }
                })
                
                guard let userId = user?.user.uid else { return }
                Firestore.firestore().collection(USERS_REF).document(userId).setData([
                    USERNAME : username,
                    DATE_CREATED : FieldValue.serverTimestamp()
                    ], completion: { (error) in
                        if let error = error {
                            
                            debugPrint("Error display name: \(error.localizedDescription)")
                        } else {
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                })
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
