//
//  AddThoughtVCViewController.swift
//  Thoughts
//
//  Created by Aidan Miskella on 15/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {
    
    // Variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    // Outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameText: UITextField!
    @IBOutlet private weak var thoughtText: UITextView!
    @IBOutlet private weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postButton.layer.cornerRadius = 4
        thoughtText.layer.cornerRadius = 4
        thoughtText.text = "My random thought..."
        thoughtText.textColor = UIColor.lightGray
        thoughtText.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        thoughtText.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        
        guard let username = userNameText.text else { return }
        
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CATEGORY : selectedCategory,
            NUM_COMMENTS : 0,
            NUM_LIKES : 0,
            THOUGHT_TEXT : thoughtText.text!,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : username
        
        ]) { (error) in
            if let error = error {
                
                debugPrint("Error adding document: \(error)")
            } else {
                
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func categoryChanged(_ sender: UISegmentedControl) {
        
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
}
