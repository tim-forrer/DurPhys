//
//  Education.swift
//  DurPhys
//
//  Created by Tim Forrer on 23/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class GettingAround {
    
    var open: Bool
    var title: String!
    var location: String!
    var category: String!
    
    init(open: Bool, title: String!, location: String!, category: String!) {
        self.open = open
        self.title = title
        self.location = location
        self.category = category
    }
    
    class func educationOptions() -> [GettingAround] {
        var educationOptions = [GettingAround]()
        let phEight = GettingAround(open: false,
                                    title: "Ph8",
                                    location: "Rochester Building",
                                    category: "education")
        let phThirty = GettingAround(open: false,
                                     title: "Ph30",
                                     location: "Rochester Building",
                                     category: "education")
        
        educationOptions.append(phEight)
        educationOptions.append(phThirty)
        
        return educationOptions
    }
    
}
