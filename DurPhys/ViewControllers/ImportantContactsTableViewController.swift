//
//  ImportantContactsTableViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 25/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import MessageUI

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
        cell.position.lineBreakMode = .byTruncatingTail
        cell.room.text = currentStaffMember.room
        cell.emailButton.setTitle(currentStaffMember.email, for: .normal)
        

        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func sendEmailTapped(_ sender: UIButton) {
        showMailComposer(email: sender.titleLabel!.text!)
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

extension ImportantContactsTableViewController: MFMailComposeViewControllerDelegate {
    func showMailComposer(email: String) {
        
        guard MFMailComposeViewController.canSendMail() else {
            //Show an alert to say your device can't send emails
            let emailAlert = UIAlertController(title: "Cannot display email composer", message: "Your device email settings have not been setup/have been setup incorrectly", preferredStyle: .alert)
            emailAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(emailAlert, animated: true)
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients([email])
        present(composer, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            //Show error alert
            controller.dismiss(animated: true)
            return
        }
        switch result {
        case .failed:
            let emailFailed = UIAlertController(title: "Error", message: "There was an error with sending your email. Please try again or send us a bug report if this keeps happening.", preferredStyle: .alert)
            emailFailed.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(emailFailed, animated: true)
            controller.dismiss(animated: true)
        default:
            controller.dismiss(animated: true)
        }
    }
    
    
}
