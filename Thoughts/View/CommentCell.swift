//
//  CommentCell.swift
//  Thoughts
//
//  Created by Aidan Miskella on 19/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

protocol CommentDelegate {
    
    func commentOptionsTapped(comment: Comment)
}

class CommentCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var timestampText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    // Variables
    private var comment: Comment!
    private var delegate: CommentDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(comment: Comment, delegate: CommentDelegate) {
        
        optionsMenu.isHidden = true
        self.comment = comment
        self.delegate = delegate
        
        usernameText.text = comment.username
        commentText.text = comment.commentText
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timestampText.text = timestamp
        
        if comment.userId == Auth.auth().currentUser?.uid {
            
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(commentOptionsTapped))
            optionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func commentOptionsTapped() {
        
        delegate?.commentOptionsTapped(comment: comment)
    }
}
