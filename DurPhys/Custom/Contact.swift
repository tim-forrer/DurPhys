//
//  Contacts.swift
//  DurPhys
//
//  Created by Tim Forrer on 25/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import SwiftSoup

class Contact {

    var section: String
    var name: String
    var position: String?
    var room: String?
    var email: String
    
    init(section: String, name: String, position: String?, room: String?, email: String) {
        self.section = section
        self.name = name
        self.position = position
        self.room = room
        self.email = email
    }
    
    
    // this passes the html from the physics staff page list into find contacts
    class func loadContactsHTML() -> [Contact] {
        let url = URL(string: "https://www.dur.ac.uk/physics/staff/list/")
        var htmlDump: String = ""
        do {
            let html = try String(contentsOf: url!)
            htmlDump = html
        } catch let error as NSError {
            print("Error: \(error)")
        }
        return findContacts(html: htmlDump)
    }
    
    //this parses the html until we've got only the table rows
    //the table rows are then passes into a final parser which finds the individual vlues for name etc.
    class func findContacts(html: String) -> [Contact] {
        var rows: [Element] = []
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let table: Element = try doc.select("table").first()!
            let tableBody: Element = try table.select("tbody").first()!
            let bodyRows: [Element] = try tableBody.select("tr").array()
            rows = bodyRows
            
        } catch Exception.Error(_ , let message) { //"let type" removed where underscore is
            print(message)
        } catch {
            print("error")
        }
        return returnStaff(tableRows: rows)
    }
    
    class func returnStaff(tableRows: [Element]) -> [Contact] {
        var staffList: [Contact] = []
        do {
            var rowSpanRemaining = 0 //this is the initial value of the rowspan for the first row
            var section = "test"
            for tableColumn in tableRows {
                let staffMember = Contact(section: "test", name: "test", position: nil, room: nil, email: "test")
                let info = try tableColumn.select("td").array()
                var index = 1
                
                if rowSpanRemaining > 0 {
                    rowSpanRemaining -= 1
                    index = 0
                } else {
                    index = 1
                    section = try info[0].text()
                    rowSpanRemaining = Int(try info[0].attr("rowspan"))! - 1
                }
                staffMember.section = section
                staffMember.name = try info[index].text()
                staffMember.position = try info[index + 1].text()
                staffMember.room = try info[index + 3].text()
                staffMember.email = try info[index + 4].text()
                print(staffMember.section)
                print(staffMember.name)
                print(staffMember.position!)
                print(staffMember.room!)
                print(staffMember.email)
                print(rowSpanRemaining)
                staffList.append(staffMember)
            }
        } catch Exception.Error( _, let message) { //removed "let type" where the underscore is
            print(message)
        } catch {
            print("error")
        }
        return staffList
    }
    
    class func sections() -> [String] {
        let contacts = loadContactsHTML()
        var sectionTitles: [String] = []
        for contact in contacts {
            if !sectionTitles.contains(contact.section) {
                sectionTitles.append(contact.section)
            }
        }
        return sectionTitles
    }
    
}
