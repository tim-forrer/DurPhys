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

class Option {
    
    var name: String?
    var label: String?
    var section: String?
    var url: String?
    var image: UIImage?
    var loginPossible: Bool
    
    init(name: String?, label: String?, section:String?, url: String?, image: UIImage?, loginPossible: Bool) {
        self.name = name
        self.label = label
        self.section = section
        self.url = url
        self.image = image
        self.loginPossible = loginPossible
    }
    
    class func nilOption() -> Option {
        let option = Option(name: nil,
                            label: nil,
                            section: nil,
                            url: nil,
                            image: nil,
                            loginPossible: false)
        return option
    }
    
    class func menuOptions() -> [Option] {
        var options: [Option] = []
    
        let gettingAround = Option(name: "gettingAround",
        label: "Getting Around",
        section: nil,
        url: nil,
        image: UIImage(named: "gettingAround")!,
        loginPossible: false)
    
        let courseInformation = Option(name: "courseInformation",
        label: "Course Information (Weekly Timetables)",
        section: nil,
        url: nil,
        image: UIImage(named: "courseInformation")!,
        loginPossible: false)
    
        let importantContacts = Option(name: "importantContacts",
        label: "Important Contacts",
        section: nil,
        url: nil,
        image: UIImage(named: "importantContacts")!,
        loginPossible: false)
    
        let teachingFormats = Option(name: "teachingFormats",
        label: "Teaching Formats",
        section: nil,
        url: nil,
        image: UIImage(named: "teachingFormats")!,
        loginPossible: false)
    
        let physicsPortal = Option(name: "physicsPortal",
        label: "Physics Portal (Homework Hand-In)",
        section: nil,
        url: "https://teaching.physics.dur.ac.uk",
        image: UIImage(named: "physicsPortal")!,
        loginPossible: true)
    
        let universityEmail = Option(name: "universityEmail",
        label: "University Email",
        section: nil,
        url: "https://adfs.durham.ac.uk/adfs/ls/?wa=wsignin1.0&wtrealm=urn:federation:MicrosoftOnline&wctx=wa%3Dwsignin1.0%26rpsnv%3D4%26ct%3D1435155873%26rver%3D6.6.6556.0%26wp%3DMBI_SSL%26wreply%3Dhttps:%252F%252Foutlook.office365.com%252Fowa%252F%253Frealm%253Ddurham.ac.uk%2526authRedirect%253Dtrue%26id%3D260563%26whr%3Ddurham.ac.uk%26CBCXT%3Dout",
        image: UIImage(named: "universityEmail")!,
        loginPossible: true)
    
        let duo = Option(name: "duo",
        label: "D.U.O.",
        section: nil,
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
    
    class func navOptions() -> [[Option]] {
        var options: [[Option]] = []
        
        //technological matters
        let gettingConnected = Option(name: "gettingConnected",
                                      label: "Getting Connected",
                                      section: "Technological Matters",
                                      url: "https://www.dur.ac.uk/cis/wireless/",
                                      image: UIImage(named: "gettingConnected")!,
                                      loginPossible: false)

        let office = Option(name: "office",
                            label: "Office365",
                            section: "Technological Matters",
                            url: "https://www.microsoft.com/en-gb/education/products/office",
                            image: UIImage(named: "office365")!,
                            loginPossible: false)
        
        let technologicalMatters = [gettingConnected,
                                    office]
        
        //feeling unwell
        let physicalWellbeing = Option(name: "physicalWellbeing",
                                       label: "Physical Wellbeing",
                                       section: "Feeling Unwell?",
                                       url: "https://www.dur.ac.uk/experience/welcome/medical/register/",
                                       image: UIImage(named: "physicalWellbeing")!,
                                       loginPossible: false)

        let mentalWellbeing = Option(name: "mentalWellbeing",
                                     label: "Mental Wellbeing",
                                     section: "Feeling Unwell?",
                                     url: "https://www.dur.ac.uk/counselling.service/",
                                     image: UIImage(named: "mentalWellbeing")!,
                                     loginPossible: false)

        let lettingUniKnow = Option(name: "lettingUniKnow",
                                    label: "Letting University Know",
                                    section: "Feeling Unwell?",
                                    url: "https://www.dur.ac.uk/student.registry/assessment/concessions.appeals/",
                                    image: UIImage(named: "lettingUniKnow")!,
                                    loginPossible: false)
        
        let feelingUnwell = [physicalWellbeing,
                             mentalWellbeing,
                             lettingUniKnow]
        
        
        //du societies
        let physSoc = Option(name: "physSoc",
                             label: "PhysSoc",
                             section: "DU Societies",
                             url: "https://www.durhamsu.com/groups/physics-20b9",
                             image: UIImage(named: "physSoc")!,
                             loginPossible: false)
        
        let astroSoc = Option(name: "astroSoc",
                              label: "AstroSoc",
                              section: "DU Societies",
                              url: "https://www.durhamsu.com/groups/astronomical",
                              image: UIImage(named: "astroSoc")!,
                              loginPossible: false)

        let duseds = Option(name: "duseds",
                            label: "DUSEDS",
                            section: "DU Societies",
                            url: "https://www.facebook.com/DurhamSEDS/",
                            image: UIImage(named: "duseds")!,
                            loginPossible: false)
        
        let dsu = Option(name: "dsu",
                         label: "DSU",
                         section: "DU Societies",
                         url: "https://www.durhamsu.com/",
                         image: UIImage(named: "dsu")!,
                         loginPossible: false)
        
        let duSocieties = [physSoc,
                           astroSoc,
                           duseds,
                           dsu]
        
        //general
        let reportBugs = Option(name: "reportBugs", label: "Report Bugs", section: "General", url: """
            mailto:physics.app@durham.ac.uk?subject=Bug Report&body=Please describe your issue as best you can using the following prompts.
            
            Device:
            
            Action taken to experience bug:
            
            Expected Result:
            
            Actual Result:
            
            Any other comments:
            
            Thanks very much! Your help is greatly appreciated. Hope you have a great day!
            """,
                        
            image: UIImage(named:"reportBugs")!,
            loginPossible: false)

        let about = Option(name: "about",
                           label: "About",
                           section: "General",
                           url: nil,
                           image: UIImage(named: "about")!,
                           loginPossible: false)
        
        let general = [reportBugs,
                       about]
        
        options.append(technologicalMatters)
        options.append(feelingUnwell)
        options.append(duSocieties)
        options.append(general)
        
        return options
    }
    
}
