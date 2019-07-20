//
//  CommentCell.swift
//  Thoughts
//
//  Created by Aidan Miskella on 19/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    // Outlets
    
    @IBOutlet weak var usernameText: UILabel!
    @IBOutlet weak var timestampText: UILabel!
    @IBOutlet weak var commentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(comment: Comment) {
        
        usernameText.text = comment.username
        commentText.text = comment.commentText
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM, hh:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timestampText.text = timestamp
    }
}
