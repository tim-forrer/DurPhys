//
//  ImportantContactsTableViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 25/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class ImportantContactsTableViewController: UITableViewController {
    
    let contactList = Contact.contacts()
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredContactList = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        filteredContactList = contactList
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContactList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "importantContactsCell", for: indexPath) as! ImportantContactsTableViewCell
        let currentStaffMember = filteredContactList[indexPath.item]
        
        cell.name.text = currentStaffMember.name
        cell.position.text = currentStaffMember.position
        cell.room.text = currentStaffMember.room

        return cell
    }

}

extension ImportantContactsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredContactList = contactList
        } else {
        filteredContactList = contactList.filter({
            $0.name.lowercased().contains(searchText.lowercased())
        })
        }
        tableView.reloadData()
    }
}
