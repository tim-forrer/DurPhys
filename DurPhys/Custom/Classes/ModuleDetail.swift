//
//  ModuleDetail.swift
//  DurPhys
//
//  Created by Tim Forrer on 06/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation

class ModuleDetail {
    
    var format: String
    var staffMember: String
    var location: String
    var timeIndex: Int
    
    init(format: String, staffMember: String, location: String, timeIndex: Int) {
        self.format = format
        self.staffMember = staffMember
        self.location = location
        self.timeIndex = timeIndex
    }

}
