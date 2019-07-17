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
    
    let navOptions = Option.navOptions()
    
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var sections: [String] = []
        for section in navOptions {
            for item in section {
                if !sections.contains(item.section!) {
                    sections.append(item.section!)
                }
            }
        }
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        var sections: [String] = []
        for section in navOptions {
            for item in section {
                if !sections.contains(item.section!) {
                    sections.append(item.section!)
                }
            }
        }
        
        var itemsInSection: Int = 0
        for section in navOptions {
            for item in section {
                if item.section == sections[sectionIndex] {
                    itemsInSection += 1
                }
            }
        }
        return itemsInSection
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sections: [String] = []
        for section in navOptions {
            for item in section {
                if !sections.contains(item.section!) {
                    sections.append(item.section!)
                }
            }
        }
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "navDrawerCell", for: indexPath)

        cell.imageView?.image = navOptions[indexPath.section][indexPath.row].image
        cell.imageView?.tintColor = UIColor(red: 104/255, green: 36/255, blue: 109/255, alpha: 1.0)
        
        cell.textLabel?.text = navOptions[indexPath.section][indexPath.row].label
        
        return cell
    }
    
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navDrawerToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        func getNavOption() -> Option {
            for section in navOptions {
                for item in section {
                    if item.label == cell?.textLabel?.text {
                        return item
                    }
                }
            }
            return navOptions[0][0] //just a random default value so there is a return outside of the nested loops
        }
        let navOption = getNavOption()
        performSegue(withIdentifier: "navDrawerToWebPage", sender: navOption)
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
    }
    
}

protocol NavDrawerViewControllerDelegate {
}
