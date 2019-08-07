//
//  ModuleDetail.swift
//  DurPhys
//
//  Created by Tim Forrer on 06/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation

class ModuleDetail {
    
    var detail: String
    var name: String
    var staffMember: String
    var location: String
    var time: String
    
    init(detail: String, name: String, staffMember: String, location: String, time: String) {
        self.detail = detail
        self.name = name
        self.staffMember = staffMember
        self.location = location
        self.time = time
    }

}
