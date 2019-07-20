//
//  Comment.swift
//  Thoughts
//
//  Created by Aidan Miskella on 19/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var commentText: String!
    
    init(username: String,
         timestamp: Date,
         commentText: String) {
        
        self.username = username
        self.timestamp = timestamp
        self.commentText = commentText
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Comment] {
    
        var comments = [Comment]()

        guard let snap = snapshot else { return comments }
        for document in snap.documents {

            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp: Timestamp = data[TIMESTAMP] as! Timestamp
            let date: Date = timestamp.dateValue()
            let commentText = data[COMMENT_TEXT] as? String ?? "A random comment..."

            let newComment = Comment(username: username, timestamp: date, commentText: commentText)
            comments.append(newComment)
        }

        return comments
    }
}
