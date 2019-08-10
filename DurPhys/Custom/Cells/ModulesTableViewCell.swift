//
//  ModulesTableViewCell.swift
//  DurPhys
//
//  Created by Tim Forrer on 07/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class ModulesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moduleName: UILabel!
    @IBOutlet weak var moduleCode: UILabel!
    @IBOutlet private weak var timetableCollectionView: UICollectionView!
    
    var collectionViewOffset: CGFloat {
        get {
            return timetableCollectionView.contentOffset.x
        }
        set {
            timetableCollectionView.contentOffset.x = newValue
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        timetableCollectionView.delegate = dataSourceDelegate
        timetableCollectionView.dataSource = dataSourceDelegate
        timetableCollectionView.tag = row
        timetableCollectionView.reloadData()
    }
    
}
