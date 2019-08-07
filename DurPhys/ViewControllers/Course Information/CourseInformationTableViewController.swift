//
//  CourseInformationViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 04/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit


//Sets up the super table view
class CourseInformationTableViewController: UITableViewController {

    
    // MARK: - Declarations    
    let modules = Module.modules()
    let fullModulesInfo = CourseInfoParser.fullModulesInfoForWeek()
    var storedOffsets = [Int: CGFloat]()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modules.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModulesTableViewCell") as! ModulesTableViewCell
        cell.moduleName.text = modules[indexPath.row].name
        cell.moduleCode.text = modules[indexPath.row].dept + String(modules[indexPath.row].code)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ModulesTableViewCell else {return}
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self as UICollectionViewDataSource & UICollectionViewDelegate, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let tableViewCell = cell as? ModulesTableViewCell else { return }
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
}

extension CourseInformationTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Utils.weekdays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimetableCollectionViewCell", for: indexPath) as! TimetableCollectionViewCell
        cell.weekday.text = Utils.weekdays[indexPath.item]
        return cell
    }
}
