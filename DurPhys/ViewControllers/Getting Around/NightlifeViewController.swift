//
//  NightlifeViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 15/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class NightlifeViewController: UIViewController {
    
    let nightlifePlaces = Place.getNightlifePlaces()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

}

extension NightlifeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return nightlifePlaces.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle(nightlifePlaces[section].name!, for: .normal)
        setButtonStyle(button: button)
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
}

extension NightlifeViewController {
    
    func setButtonStyle(button: UIButton) {
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.contentHorizontalAlignment = .left
        button.tintColor = .white
        button.backgroundColor = Utils.palatinate
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
    }
    
}
