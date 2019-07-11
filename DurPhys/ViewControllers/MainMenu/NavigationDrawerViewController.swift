//
//  NavigationDrawerViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 11/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class NavigationDrawerViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var delegate: NavigationDrawerViewControllerDelegate?
    
    var drawerOptions = [
    "Getting Connected",
    "Office 365",
    "Physical Wellbeing",
    "Mental Wellbeing",
    "Letting University Know",
    "PhysSoc",
    "AstroSoc",
    "DUSEDs",
    "DSU Website",
    "Report Bugs",
    "About",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

// MARK: Table View Data Source
extension NavigationDrawerViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawerOptions.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "navigationDrawerCell", for: indexPath) as! NavigationDrawerTableViewCell
        cell.navigationDrawerLabel.text = drawerOptions[indexPath.item]
    
        return cell
    }
}

// Mark: Table View Delegate

extension NavigationDrawerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

protocol NavigationDrawerViewControllerDelegate {
}
