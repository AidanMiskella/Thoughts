//
//  ThoughtCellTableViewCell.swift
//  Thoughts
//
//  Created by Aidan Miskella on 16/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var thoughtTextLabel: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(thought: Thought) {
        
        
    }

}
