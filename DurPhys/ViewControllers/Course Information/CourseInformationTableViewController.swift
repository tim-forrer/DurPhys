//
//  CourseInformationViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 04/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class CourseInformationTableViewController: UITableViewController {
    
    // MARK: - Declarations
    let modules = Module.modules()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = Utils.palatinate
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleListCell") as! ModuleListTableViewCell
        
        cell.moduleName.text = modules[indexPath.item].name
        cell.moduleCode.text = modules[indexPath.item].dept + String(modules[indexPath.item].code)
        
        return cell
    }

}
