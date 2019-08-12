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
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    
    func getModuleTimetable(moduleCode: String, completionHandler: @escaping([[ModuleDetail]])->Void) {
        let keychain = KeychainSwift()
        
        guard let url = URL(string: "https://timetable.dur.ac.uk/reporting/individual;module;name;\(moduleCode)%0D%0A?days=1-5&weeks=20&periods=5-41&template=module+individual&height=100&week=100") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let headerValue = keychain.get("username")! + ":" + keychain.get("password")!
        let utfHeaderValue = headerValue.data(using: .utf8, allowLossyConversion: false)
        let base64HeaderValue = utfHeaderValue?.base64EncodedString()
        let finalHeaderValue = "Basic " + base64HeaderValue!
        request.setValue(finalHeaderValue, forHTTPHeaderField: "Authorization")
        
        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                let moduleDetails = self!.parseDataToModuleDetails(data: data)
                DispatchQueue.main.async {
                    completionHandler(moduleDetails)
                }
            }
        }
        dataTask?.resume()
    }
    
    private func parseDataToModuleDetails(data: Data) -> [[ModuleDetail]]{
        let dataString = String(data: data, encoding: String.Encoding.utf8) as String?
        var moduleDetailsForWeek: [[ModuleDetail]] = []
        for (index, _ ) in Utils.weekdays.enumerated() {
            let tableRowCells = getTableRowCells(html: dataString!, weekday: index)
            let moduleDetails = getModuleDetails(moduleInfoForWeekday: tableRowCells!)
            moduleDetailsForWeek.append(moduleDetails)
        }
        return moduleDetailsForWeek
    }
    

    private func getTableRowCells(html: String, weekday: Int) -> [Element]? { //this will return the timetable information for a given weekday
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

    private func getModuleDetails(moduleInfoForWeekday: [Element]) -> [ModuleDetail] { //returns an array of ModuleDetail for that given day
        var timeIndex = 0 //tracks what time it is, 9:00 being timeIndex 0, and incrementing in periods of 15mins
        var moduleDetails: [ModuleDetail] = []
        do {
            for (index, tableRowCell) in moduleInfoForWeekday.enumerated() { // tidy this up lots, very messy atm
                if index > 0 {
                    if try tableRowCell.text() != "" && moduleInfoForWeekday[index - 1].text() == "" {
                        let moduleDetail = getModuleDetailForTime(tableRowCell: tableRowCell, timeIndex: timeIndex)
                        moduleDetails.append(moduleDetail!)
                        timeIndex += 4
                    } else if try tableRowCell.text() != "" && moduleInfoForWeekday[index - 1].text() != ""{
                        let moduleDetail = getModuleDetailForTime(tableRowCell: tableRowCell, timeIndex: timeIndex)
                        moduleDetails.append(moduleDetail!)
                    }
                } else {
                    if try tableRowCell.text() != "" {
                        let moduleDetail = getModuleDetailForTime(tableRowCell: tableRowCell, timeIndex: timeIndex)
                        moduleDetails.append(moduleDetail!)
                        timeIndex += 4
                    } else {
                        timeIndex += 1
                    }

                }
            }
            return moduleDetails
        } catch {
            print("There was an error when getting module details")
            return []
        }
    }

    private func getModuleDetailForTime(tableRowCell: Element, timeIndex: Int) -> ModuleDetail? {
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

