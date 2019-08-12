//
//  CourseInfoQuery.swift
//  DurPhys
//
//  Created by Tim Forrer on 06/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation
import SwiftSoup
import KeychainSwift

class CourseInfoQuery{
    
    class func requestTimetable(moduleCode: String, completionBlock: @escaping (String) -> Void) -> Void
    {
        let keychain = KeychainSwift()
        let requestURL = URL(string: "https://timetable.dur.ac.uk/reporting/individual;module;name;\(moduleCode)%0D%0A?days=1-5&weeks=20&periods=5-41&template=module+individual&height=100&week=100")
        var request = URLRequest(url: requestURL!)
        
        request.httpMethod = "GET"
        let headerValue = keychain.get("username")! + ":" + keychain.get("password")!
        let utfHeaderValue = headerValue.data(using: .utf8, allowLossyConversion: false)
        let base64HeaderValue = utfHeaderValue?.base64EncodedString()
        let finalHeaderValue = "Basic " + base64HeaderValue!
        request.setValue(finalHeaderValue, forHTTPHeaderField: "Authorization")
        
        let requestTask = URLSession.shared.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if(error != nil) {
                print("Error: \(String(describing: error))")
            }else
            {
                let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String?
                //send this block to required place
                DispatchQueue.main.async {
                    completionBlock(outputStr!)
                }
            }
        }
        
        requestTask.resume()
    }

    class func tableRowCellsForDay(html: String, weekday: Int) -> [Element]? { //this will return the timetable information for a given weekday
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let tables: [Element] = try doc.getElementsByTag("table").array()
            let table: Element = tables[6]
            let tableRows: [Element] = try table.select("tr").array()//returns the rows for everyday of the week
            let tableRow : Element = tableRows[0].siblingElements()[weekday] //returns the row for the given weekday
            let tableRowCells: [Element] = try tableRow.select("td").array()[0].siblingElements().array() //returns all the cells for that given weekday
            
            return tableRowCells
            
        } catch Exception.Error(_ , let message) {
            print(message)
            return nil
        } catch {
            print("error")
            return nil
        }
    }

    class func moduleInfo(moduleInfoForWeekday: [Element]) -> [ModuleDetail] { //returns an array of ModuleDetail for that given day
        var timeIndex = 0 //tracks what time it is, 9:00 being timeIndex 0, and incrementing in periods of 15mins
        var moduleInfoArray = [ModuleDetail]()
        do {
            for tableRowCell in moduleInfoForWeekday {
                if try tableRowCell.text() != "" {
                    let moduleDetail = retrieveModuleInfoForGivenTime(tableRowCell: tableRowCell, timeIndex: timeIndex)
                    moduleInfoArray.append(moduleDetail!)
                    timeIndex += 4
                } else {
                    timeIndex += 1
                }
            }
            return moduleInfoArray
        } catch {
            print("There was an error")
            return  moduleInfoArray
        }
    }

    class func retrieveModuleInfoForGivenTime(tableRowCell: Element, timeIndex: Int) -> ModuleDetail? {
        let moduleDetail = ModuleDetail(detail: "placeholder", name: "placeholder", staffMember: "placeholder", location: "placeholder", time: "placeholder")
        do {
            let subTables = try tableRowCell.select("table").array()
            var joinedTableRows: [Element] = []
            for subTable in subTables {
                let  subTableRows = try subTable.select("td").array()
                for subTableRow in subTableRows {
                    joinedTableRows.append(subTableRow)
                }
            }
            moduleDetail.detail = try joinedTableRows[0].text()
            moduleDetail.staffMember = try joinedTableRows[4].text()
            moduleDetail.location = try joinedTableRows[5].text()
            let time = String((540 + timeIndex * 15) / 60) + ":00"
            moduleDetail.time = time
            return moduleDetail
        }
        catch let error as NSError {
            print("Error: \(error)")
            return nil
        }
    }
    
    class func allModulesInfo() -> [[[ModuleDetail]]]{
        var allModulesInfo: [[[ModuleDetail]]] = []
        for module in Module.modules() { //iterates over each module
            let moduleCode = module.dept + String(module.code)
            CourseInfoParser.requestTimetable(moduleCode: moduleCode) { (output) in
                var fullWeekModuleDetail: [[ModuleDetail]] = []
                for (index, _) in Utils.weekdays.enumerated() { //iterates over each day
                    let tableRowCells = CourseInfoParser.tableRowCellsForDay(html: output, weekday: index)
                    let moduleDetailForDay = CourseInfoParser.moduleInfo(moduleInfoForWeekday: tableRowCells!)
                    fullWeekModuleDetail.append(moduleDetailForDay)
                }
                allModulesInfo.append(fullWeekModuleDetail)
                print(allModulesInfo)
            }
        }
        return allModulesInfo
    }

}

//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        createRequest(){ (output) in
//            let _ = moduleInfo(moduleInfoForWeekday: tableRowCellsForDay(html: output, weekday: 1)!)
//        }
//    }
//
//
//}
