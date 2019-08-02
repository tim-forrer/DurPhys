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
        
        filteredContactList = contactList
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        let contactSections = Contact.sections(contactList: contactList)
        return contactSections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let contactSections = Contact.sections(contactList: contactList)
        return contactSections[section]
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        let contactSections = Contact.sections(contactList: contactList)
        for contact in contactList {
            if contact.section == contactSections[section] {
                count += 1
            }
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "importantContactsCell", for: indexPath) as! ImportantContactsTableViewCell
        let currentStaffMember = contactList[indexPath.item]
        
        cell.name.text = currentStaffMember.name
        cell.position.text = currentStaffMember.position
        cell.room.text = currentStaffMember.room

        return cell
    }

}
