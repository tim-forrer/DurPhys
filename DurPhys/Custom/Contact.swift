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
    class func loadContactsHTML() -> String? {
        let url = URL(string: "https://www.dur.ac.uk/physics/staff/list/")
        do {
            let html = try String(contentsOf: url!)
            return html
        } catch let error as NSError {
            print("Error: \(error)")
            return nil
        }
    }
    
    //this parses the html until we've got only the table rows
    //the table rows are then passes into a final parser which finds the individual vlues for name etc.
    class func findContacts(html: String) -> [Element]? {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let table: Element = try doc.select("table").first()!
            let tableBody: Element = try table.select("tbody").first()!
            let tableBodyRows: [Element] = try tableBody.select("tr").array()
            return tableBodyRows
            
        } catch Exception.Error(_ , let message) { //"let type" removed where underscore is
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }
    
    class func returnStaff(tableBodyRows: [Element]) -> [Contact] {
        var staffList: [Contact] = []
        do {
            var rowSpanRemaining = 0 //this is the initial value of the rowspan for the first row
            var section = "test"
            for tableColumn in tableBodyRows {
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
                staffList.append(staffMember)
            }
        } catch Exception.Error( _, let message) { //removed "let type" where the underscore is
            print(message)
        } catch {
            print("error")
        }
        return staffList
    }
    
    class func contacts() -> [Contact] {
        let html = loadContactsHTML()
        let staffTable = findContacts(html: html!)!
        let staffList = returnStaff(tableBodyRows: staffTable)
        return staffList
    }
    
    class func sections(contactList: [Contact]) -> [String] {
        var sectionTitles: [String] = []
        for contact in contactList {
            if !sectionTitles.contains(contact.section) {
                sectionTitles.append(contact.section)
            }
        }
        return sectionTitles
    }
    
    class func twoDimArray(sections: [String], contacts: [Contact]) -> [[Contact]] {
        var twoDimensionalArray: [[Contact]] = []
        var contactList = contacts
        for section in sections {
            var currentSection: [Contact] = []
            for contact in contactList {
                if contact.section == section {
                    currentSection.append(contact) //can optimise here to remove the contact from contacts once it's put into a section
                    contactList.removeFirst() //attempt at that optimsation
                }
            }
            twoDimensionalArray.append(currentSection)
        }
        return twoDimensionalArray
    }
    
}
