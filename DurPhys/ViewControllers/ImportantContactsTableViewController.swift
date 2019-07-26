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
    @IBOutlet weak var searcBar: UISearchBar!
    var filteredContact = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        
        tableView.delegate = self
        tableView.dataSource = self
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
        let contactSections = Contact.sections(contactList: contactList)
        let twoDimArray = Contact.twoDimArray(sections: contactSections, contacts: contactList)
        return twoDimArray[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "importantContactsCell", for: indexPath) as! ImportantContactsTableViewCell
        
        let contactSections = Contact.sections(contactList: contactList)
        let twoDimArray = Contact.twoDimArray(sections: contactSections, contacts: contactList)
        
        cell.name.text = twoDimArray[indexPath.section][indexPath.row].name
        cell.position.text = twoDimArray[indexPath.section][indexPath.row].position
        cell.room.text = twoDimArray[indexPath.section][indexPath.row].room

        return cell
    }

}
