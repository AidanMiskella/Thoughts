//
//  Thought.swift
//  Thoughts
//
//  Created by Aidan Miskella on 16/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import Foundation
import Firebase

class Thought {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var thoughtText: String!
    private(set) var numLikes: Int!
    private(set) var numComments: Int!
    private(set) var documentId: String!
    private(set) var userId: String!
    
    init(username: String,
         timestamp: Date,
         thoughtText: String,
         numLikes: Int,
         numComments: Int,
         documentId: String,
         userId: String) {
        
        self.username = username
        self.timestamp = timestamp
        self.thoughtText = thoughtText
        self.numLikes = numLikes
        self.numComments = numComments
        self.documentId = documentId
        self.userId = userId
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Thought] {
        
        var thoughts = [Thought]()
        
        guard let snap = snapshot else { return thoughts }
        for document in snap.documents {
            
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp: Timestamp = data[TIMESTAMP] as! Timestamp
            let date: Date = timestamp.dateValue()
            let thoughtText = data[THOUGHT_TEXT] as? String ?? "A random thought..."
            let numLikes = data[NUM_LIKES] as? Int ?? 0
            let numComments = data[NUM_COMMENTS] as? Int ?? 0
            let documentId = document.documentID
            let userId = document[USER_ID] as? String ?? ""
            
            let newThought = Thought(username: username, timestamp: date, thoughtText: thoughtText, numLikes: numLikes, numComments: numComments, documentId: documentId, userId: userId)
            thoughts.append(newThought)
        }
        
        return thoughts
    }
}
