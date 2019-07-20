//
//  CommentsVC.swift
//  Thoughts
//
//  Created by Aidan Miskella on 19/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var keyBoardView: UIView!
    @IBOutlet weak var addCommentText: UITextField!
    
    // Variables
    var thought: Thought!
    var comments = [Comment]()
    var thoughtRef: DocumentReference!
    let firestore = Firestore.firestore()
    var username: String!
    var commentListener: ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        thoughtRef = firestore.collection(THOUGHTS_REF).document(thought.documentId)
        if let name = CURRENT_USER?.displayName {
            
            username = name
        }
        
        self.view.bindToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        commentListener = firestore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF)
            .order(by: TIMESTAMP, descending: false)
            .addSnapshotListener({ (snapshot, error) in
            
            guard let snapshot = snapshot else {
                
                debugPrint("Error fetching comments: \(error!)")
                return
            }
            
            self.comments.removeAll()
            self.comments = Comment.parseData(snapshot: snapshot)
            self.tableView.reloadData()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        commentListener.remove()
    }
    
    @IBAction func addCommentTapped(_ sender: Any) {
        
        guard let commentText = addCommentText.text else { return }
        
        firestore.runTransaction({ (transaction, errorPointer) -> Any? in
            
            let thoughtDocument: DocumentSnapshot
            
            do {
                
                try thoughtDocument = transaction.getDocument(self.firestore
                .collection(THOUGHTS_REF).document(self.thought.documentId))
            } catch let error as NSError{
                
                debugPrint("Fetch error: \(error.localizedDescription)")
                return nil
            }
            
            guard let oldNumComments = thoughtDocument.data()![NUM_COMMENTS] as? Int else { return nil }
            
            transaction.updateData([NUM_COMMENTS : oldNumComments + 1], forDocument: self.thoughtRef)
            
            let newCommentRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.documentId).collection(COMMENTS_REF).document()
            
            transaction.setData([
                COMMENT_TEXT : commentText,
                TIMESTAMP : FieldValue.serverTimestamp(),
                USERNAME : self.username!
                ], forDocument: newCommentRef, merge: true)
            
            return nil
        }) { (object, error) in
            
            if let error = error {
                
                debugPrint("Transaction failed \(error)")
            } else {
                
                self.addCommentText.text = ""
                self.addCommentText.resignFirstResponder()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentCell {
            
            cell.configureCell(comment: comments[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
