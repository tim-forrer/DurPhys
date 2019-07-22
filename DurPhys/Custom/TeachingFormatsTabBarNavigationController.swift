//
//  TeachingFormatsTabBarNavigationController.swift
//  DurPhys
//
//  Created by Tim Forrer on 22/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class TeachingFormatsTabBarNavigationController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarStyle()
    }
    
    func tabBarStyle() {
        tabBar.barTintColor = Utils.palatinate
        tabBar.tintColor = .white
    }
    
    
}
