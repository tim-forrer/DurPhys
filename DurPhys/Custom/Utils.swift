//
//  Utils.swift
//  DurPhys
//
//  Created by Tim Forrer on 11/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class Utils {
    static func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    static let palatinate = UIColor(red: 104/255, green: 36/255, blue: 109/255, alpha: 1.0)
    static let heather = UIColor(red: 203/255, green: 168/255, blue: 177/255, alpha: 1.0)
    
    
    
}

class MenuOption {
    
    let name: String
    let label: String
    let url: String?
    let image: UIImage
    let loginPossible: Bool
    
    init(name: String, label: String, url: String?, image: UIImage, loginPossible: Bool) {
        self.name = name
        self.label = label
        self.url = url
        self.image = image
        self.loginPossible = loginPossible
    }
    
    class func menuOptions() -> [MenuOption] {
        var options: [MenuOption] = []
    
        let gettingAround = MenuOption(name: "gettingAround",
        label: "Getting Around",
        url: nil,
        image: UIImage(named: "gettingAround")!,
        loginPossible: false)
    
        let courseInformation = MenuOption(name: "courseInformation",
        label: "Course Information (Weekly Timetables)",
        url: nil,
        image: UIImage(named: "courseInformation")!,
        loginPossible: false)
    
        let importantContacts = MenuOption(name: "importantContacts",
        label: "Important Contacts",
        url: nil,
        image: UIImage(named: "importantContacts")!,
        loginPossible: false)
    
        let teachingFormats = MenuOption(name: "teachingFormats",
        label: "Teaching Formats",
        url: nil,
        image: UIImage(named: "teachingFormats")!,
        loginPossible: false)
    
        let physicsPortal = MenuOption(name: "physicsPortal",
        label: "Physics Portal (Homework Hand-In)",
        url: "https://teaching.physics.dur.ac.uk",
        image: UIImage(named: "physicsPortal")!,
        loginPossible: true)
    
        let universityEmail = MenuOption(name: "universityEmail",
        label: "University Email",
        url: "https://adfs.durham.ac.uk/adfs/ls/?wa=wsignin1.0&wtrealm=urn:federation:MicrosoftOnline&wctx=wa%3Dwsignin1.0%26rpsnv%3D4%26ct%3D1435155873%26rver%3D6.6.6556.0%26wp%3DMBI_SSL%26wreply%3Dhttps:%252F%252Foutlook.office365.com%252Fowa%252F%253Frealm%253Ddurham.ac.uk%2526authRedirect%253Dtrue%26id%3D260563%26whr%3Ddurham.ac.uk%26CBCXT%3Dout",
        image: UIImage(named: "universityEmail")!,
        loginPossible: true)
    
        let duo = MenuOption(name: "duo",
        label: "D.U.O.",
        url: "https://duo.dur.ac.uk",
        image: UIImage(named: "duo")!,
        loginPossible: true)
    
        options.append(gettingAround)
        options.append(courseInformation)
        options.append(importantContacts)
        options.append(teachingFormats)
        options.append(physicsPortal)
        options.append(universityEmail)
        options.append(duo)
    
        return options
    
    }
}
