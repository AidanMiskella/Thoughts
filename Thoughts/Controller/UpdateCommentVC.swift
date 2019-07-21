//
//  UpdateCommentVC.swift
//  Thoughts
//
//  Created by Aidan Miskella on 21/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class UpdateCommentVC: UIViewController {

    // Outlets
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet weak var updateButton: UIButton!
    
    // Variables
    var commentData : (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentText.layer.cornerRadius = 4
        updateButton.layer.cornerRadius = 4
        commentText.text = commentData.comment.commentText
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.documentId)
        .collection(COMMENTS_REF).document(commentData.comment.documentId)
            .updateData([COMMENT_TEXT : commentText.text]) { (error) in
                if let error = error {
                    
                    debugPrint("Error updating comment \(error.localizedDescription)")
                } else {
                    
                    self.navigationController?.popViewController(animated: true)
                }
        }
    }
}
