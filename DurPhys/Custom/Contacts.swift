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
    
    var position: String?
    var name: String
    var room: String?
    var email: String
    
    init(name: String, position: String?, room: String?, email: String) {
        self.position = position
        self.name = name
        self.room = room
        self.email = email
    }
    
    class func loadContactsHTML() {
        let url = URL(string: "https://www.dur.ac.uk/physics/staff/list/")
        do {
            let html = try String(contentsOf: url!)
            findContacts(html: html)
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    class func findContacts(html: String) {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let staffTable: Element = try doc.select("table").first()!
            let tableBody: Element = try staffTable.select("tbody").first()!
            let staffRows: [Element] = try tableBody.select("tr").array()
            print(returnStaff(staffRows: staffRows))
            
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    class func returnStaff(staffRows: [Element]) -> [Contact] {
        var staffList: [Contact] = []
        do {
            for staffInfo in staffRows {
                let staffMember = Contact(name: "init", position: nil, room: nil, email: "init")
                let columnEntries = try staffInfo.select("td").array()
                print(columnEntries)
                for staffColumn in columnEntries {
                    let staffSections = try staffColumn.getElementsByAttributeValueNot("rowspan", "1").array()
                    print(staffSections)
                    staffMember.position = try staffSections[1].text()
                    staffMember.name = try staffSections[0].text()
                    staffMember.room = try staffSections[3].text()
                    staffMember.email = try staffSections[4].text()
                    print(staffMember.name)
                    staffList.append(staffMember)
                }
            }
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
        return staffList
    }
    
}
