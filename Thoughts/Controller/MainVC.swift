//
//  ViewController.swift
//  Thoughts
//
//  Created by Aidan Miskella on 15/07/2019.
//  Copyright © 2019 Aidan Miskella. All rights reserved.
//

import UIKit

enum ThoughtCategory: String {
    
    case serious = "Serious"
    case funny = "Funny"
    case crazy = "Crazy"
    case popular = "Popular"
}

class MainVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // Varibles
    private var thoughts = [Thought]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return thoughts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "thoughtCell", for: indexPath) as? ThoughtCell {
            
            cell.configureCell(thought: thoughts[indexPath.row])
            
            return cell
        } else {
            
            return UITableViewCell()
        }
    }

}

