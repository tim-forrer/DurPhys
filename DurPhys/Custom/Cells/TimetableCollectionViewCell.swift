//
//  TimetableCollectionViewCell.swift
//  DurPhys
//
//  Created by Tim Forrer on 07/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class TimetableCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weekday: UILabel!
    @IBOutlet private weak var timetableTableView: TimetableTableView!
    
    var collectionViewTag = Int()
    
    func setTimetableTableViewDataSourceDelegate(dataSourceDelegate: UITableViewDataSource & UITableViewDelegate, forItem item: Int) {
        timetableTableView.delegate = dataSourceDelegate
        timetableTableView.dataSource = dataSourceDelegate
        timetableTableView.tag = item
        timetableTableView.superViewTag = collectionViewTag
        timetableTableView.reloadData()
    }
}
