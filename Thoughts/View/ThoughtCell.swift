//
//  ThoughtCellTableViewCell.swift
//  Thoughts
//
//  Created by Aidan Miskella on 16/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var thoughtTextLabel: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var commentsImg: UIImageView!
    @IBOutlet weak var numCommentsLabel: UILabel!
    
    // Variables
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likesImg.addGestureRecognizer(tap)
        likesImg.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped() {
        
        Firestore.firestore().collection(THOUGHTS_REF).document(thought.documentId).updateData([NUM_LIKES : thought.numLikes + 1])
    }

    func configureCell(thought: Thought) {
        
        self.thought = thought
        usernameLabel.text = thought.username
        thoughtTextLabel.text = thought.thoughtText
        numLikesLabel.text = String(thought.numLikes)
        numCommentsLabel.text = String(thought.numComments)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, hh:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        timestampLabel.text = timestamp
    }

}
