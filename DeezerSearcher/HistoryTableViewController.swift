//
//  HistoryTableViewController.swift
//  DeezerSearcher
//
//  Created by Dima Opalko on 9/10/19.
//  Copyright © 2019 Dima Opalko. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    var savedRequests: [Request] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchSearchRequests() {
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = savedRequests[indexPath.row].text
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
