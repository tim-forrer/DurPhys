//
//  NavigationDrawerViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 11/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class NavDrawerViewController: UITableViewController {
    
    // MARK: - Declarations
    
    let sections = [
        "Technological Matters",
        "Feeling Unwell?",
        "DU Societies",
        "General",
    ]
    
    
    let drawerOptions = [
        [
            "Getting Connected",
            "Office 365"
        ],
        [
            "Physical Wellbeing",
            "Mental Wellbeing",
            "Letting University Know"
        ],
        [
            "PhysSoc",
            "AstroSoc",
            "DUSEDs",
            "DSU Website"
        ],
        [
            "Report Bugs",
            "About"
        ],
    ]
    
    let icons = [
        [
            UIImage(named: "gettingConnected"),
            UIImage(named: "office365"),
        ],
        [
            UIImage(named: "physicalWellbeing"),
            UIImage(named: "mentalWellbeing"),
            UIImage(named: "lettingUniKnow"),
        ],
        [
            UIImage(named: "physsoc"),
            UIImage(named: "astrosoc"),
            UIImage(named: "duseds"),
            UIImage(named: "dsu"),
        ],
        [
            UIImage(named: "bugs"),
            UIImage(named: "about"),
        ],
    ]
    
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drawerOptions[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "navDrawerCell", for: indexPath)
        cell.imageView?.image = icons[indexPath.section][indexPath.row]
        cell.imageView?.tintColor = UIColor(red: 104/255, green: 36/255, blue: 109/255, alpha: 1.0)
        
        cell.textLabel?.text = drawerOptions[indexPath.section][indexPath.row]
        
        return cell
    }
    
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navDrawerToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.menuOption = sender as? MenuOption
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let cellText = cell?.textLabel?.text
        performSegue(withIdentifier: "navDrawerToWebPage", sender: cellText)
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
    }
    
}

protocol NavDrawerViewControllerDelegate {
}
