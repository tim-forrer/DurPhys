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
    var storedOffsets = [Int: CGFloat]()
    var courseInfoQuery = CourseInfoQuery()
    var allModulesDetailsDict = [ String : [[ModuleDetail]] ]()
    var allModulesDetailsArray: [[[ModuleDetail]]] = []
    
    var activitySpinner = UIActivityIndicatorView()
    
    @IBOutlet var superTableView: UITableView!
    @IBOutlet weak var timetableTableView: TimetableTableView!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showActivitySpinner()
        
        getAllModulesDetails() { [weak self] in
            print("executing completion handler")
            for module in self!.modules {
                print((self?.allModulesDetailsDict[module.fullCode]!)!)
                self?.allModulesDetailsArray.append((self?.allModulesDetailsDict[module.fullCode]!)!)
            }
            self?.hideActivitySpinner()
            self?.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == superTableView {
            return modules.count
        } else if allModulesDetailsArray.isEmpty || !allModulesDetailsArray.indices.contains((tableView as! TimetableTableView).superViewTag) {
            return 1
        } else {
            let numRows = allModulesDetailsArray[(tableView as! TimetableTableView).superViewTag][tableView.tag].count
            return numRows
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == superTableView {
            return 300
        } else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == superTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModulesTableViewCell") as! ModulesTableViewCell
            cell.moduleName.text = modules[indexPath.row].name
            cell.moduleCode.text = modules[indexPath.row].dept + String(modules[indexPath.row].code)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimetableTableViewCell") as! TimetableTableViewCell
            if allModulesDetailsArray.isEmpty || !allModulesDetailsArray.indices.contains((tableView as! TimetableTableView).superViewTag) {
                cell.moduleDetail.text = "Loading..."
            } else {
                //cell.moduleDetail.adjustsFontSizeToFitWidth = true
                let moduleDetail = allModulesDetailsArray[(tableView as! TimetableTableView).superViewTag][tableView.tag][indexPath.row]
                let textString = getTextStringFromDetail(moduleDetail: moduleDetail)
                cell.moduleDetail.text = textString
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == superTableView {
            guard let tableViewCell = cell as? ModulesTableViewCell else {return}
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self as UICollectionViewDataSource & UICollectionViewDelegate, forRow: indexPath.row)
            tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
        }
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == superTableView {
            guard let tableViewCell = cell as? ModulesTableViewCell else { return }
            storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
        }
    }
    
}

extension CourseInformationTableViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Utils.weekdays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimetableCollectionViewCell", for: indexPath) as! TimetableCollectionViewCell
        cell.weekday.text = Utils.weekdays[indexPath.item]
        cell.collectionViewTag = collectionView.tag
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.75, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let collectionViewCell = cell as? TimetableCollectionViewCell else {return}
        collectionViewCell.setTimetableTableViewDataSourceDelegate(dataSourceDelegate: self as UITableViewDataSource & UITableViewDelegate, forItem: indexPath.item)
    }
}

// MARK: - Handle retrieval of module information
extension CourseInformationTableViewController {
    
    func getAllModulesDetails(completionHandler: @escaping() -> Void) {
        for module in modules {
            courseInfoQuery.getModuleTimetable(moduleCode: module.fullCode) { [weak self] moduleCode, moduleDetails in
                self?.allModulesDetailsDict[moduleCode] = moduleDetails
                if moduleCode == self?.modules.last?.fullCode {
                    print("function done, passing to completion handler")
                    completionHandler()
                }
            }
        }
    }
    
    func getTextStringFromDetail(moduleDetail: ModuleDetail) -> String {
        let time = String((540 + moduleDetail.timeIndex * 15)/60) + ":00 : "
        let format = moduleDetail.format + " - "
        let staffMember = moduleDetail.staffMember + " ("
        let location = moduleDetail.location + ")"
        let string = time + format + staffMember + location
        
        return string
    }
}

// MARK: - Style
extension CourseInformationTableViewController {
    
    func showActivitySpinner() {
        activitySpinner.center = self.view.center
        activitySpinner.startAnimating()
        self.view.alpha = 0.3
        self.view.addSubview(activitySpinner)
    }
    
    func hideActivitySpinner() {
        activitySpinner.hidesWhenStopped = true
        activitySpinner.stopAnimating()
        self.view.alpha = 1
    }
}
