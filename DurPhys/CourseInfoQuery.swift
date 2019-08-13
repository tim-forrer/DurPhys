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
    
    func getModuleTimetable(moduleCode: String, completionHandler: @escaping(String, [[ModuleDetail]])->Void) {
        guard let url = URL(string: "https://timetable.dur.ac.uk/reporting/individual;module;name;\(moduleCode)%0D%0A?days=1-5&weeks=20&periods=5-41&template=module+individual&height=100&week=100") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(getRequestHeader(), forHTTPHeaderField: "Authorization")
        
        dataTask = defaultSession.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                let moduleDetails = self!.parseDataToModuleDetails(data: data)
                DispatchQueue.main.async {
                    completionHandler(moduleCode, moduleDetails)
                }
            }
        }
        dataTask?.resume()
    }

}

// MARK: - HTML parsing functions
extension CourseInfoQuery {
    
    private func parseDataToModuleDetails(data: Data) -> [[ModuleDetail]] {
        let html = (String(data: data, encoding: String.Encoding.utf8) as String?)!
        let parentTable = getParentTable(html: html)
        let parentTableRows = getParentTableRows(parentTable: parentTable!)
        var moduleDetailsForWeek: [[ModuleDetail]] = []
        var rowIndex = 1
        
        for _ in Utils.weekdays {
            var firstRowForDay = true
            var moduleDetailsForDay: [ModuleDetail] = []
            var rowsLeft = 1
            
            while rowsLeft > 0 {
                
                let parentRow = parentTableRows![rowIndex]
                var parentRowCells = getParentRowCells(parentRow: parentRow)
                
                if firstRowForDay {
                    let firstCell = parentRowCells?.first
                    rowsLeft = getRowSpanFromCell(cell: firstCell!)! - 1
                    firstRowForDay = false
                    parentRowCells?.remove(at: 0)
                } else {
                    rowsLeft -= 1
                }
                let moduleDetails = getModuleDetailsFromCells(cells: parentRowCells!)
                moduleDetailsForDay.append(contentsOf: moduleDetails)
                moduleDetailsForDay = sortModuleDetailsByTime(moduleDetails: moduleDetailsForDay)
                rowIndex += 1
            }
            
            moduleDetailsForWeek.append(moduleDetailsForDay)
            
        }
        return moduleDetailsForWeek
    }
    
    private func getParentTable(html: String) -> Element? {
        do {
            let doc: Document = try SwiftSoup.parse(html)
            let tables: [Element] = try doc.select("table").array()
            let desiredTable = tables[6]
            return desiredTable
        } catch {
            print("Error with getSuperTable() \(error)")
            return nil
        }
    }
    
    private func getParentTableRows(parentTable: Element) -> [Element]? {
        do {
            let allTableRows: [Element] = try parentTable.select("tr").array()
            var desiredTableRows: [Element] = (allTableRows.first?.siblingElements().array())!
            desiredTableRows.insert(allTableRows.first!, at: 0)
            return desiredTableRows
        } catch {
            print("Error with getSuperTableRows() \(error)")
            return nil
        }
    }
    
    private func getParentRowCells(parentRow: Element) -> [Element]? {
        do {
            let allCells = try parentRow.select("td")
            var desiredCells = allCells.first()?.siblingElements().array()
            desiredCells?.insert(allCells.first()!, at: 0)
            return desiredCells
        } catch {
            print("Error with getParentRowCells() \(error)")
            return nil
        }
    }
    
    private func getRowSpanFromCell(cell: Element) -> Int? {
        do {
            let rowSpan = try cell.attr("rowspan")
            return Int(rowSpan)!
        } catch {
            print("Error with getRowSpanFromCell() \(error)")
            return nil
        }
    }
    
    private func getModuleDetailsFromCells(cells: [Element]) -> [ModuleDetail] {
        var timeIndex = 0
        var moduleDetails: [ModuleDetail] = []
        for cell in cells {
            if getCellText(cell: cell) == "" {
                timeIndex += 1
            } else {
                let childTables = getChildTables(cell: cell)
                let childTablesCells = getChildTablesCells(childTables: childTables!)
                let format = getFormatFromCell(cell: childTablesCells[0])
                let staffMember = getStaffMemberFromCell(cell: childTablesCells[4])
                let location = getLocationFromCell(cell: childTablesCells[5])
                let moduleDetail = ModuleDetail(format: format, staffMember: staffMember, location: location, timeIndex: timeIndex)
                moduleDetails.append(moduleDetail)
                timeIndex += 4
            }
        }
        return moduleDetails
    }
}

// MARK: - Utility functions
extension CourseInfoQuery {
    
    private func getRequestHeader() -> String {
        let keychain = KeychainSwift()
        let headerValue = keychain.get("username")! + ":" + keychain.get("password")!
        let utfHeaderValue = headerValue.data(using: .utf8, allowLossyConversion: false)
        let base64HeaderValue = utfHeaderValue?.base64EncodedString()
        let finalHeader = "Basic " + base64HeaderValue!
        
        return finalHeader
    }
    
    private func getCellText(cell: Element) -> String? {
        do {
            return try cell.text()
        } catch {
            print("Error with getCellText() \(error)")
            return nil
        }
    }
    
    private func getChildTables(cell: Element) -> [Element]? {
        do {
            return try cell.select("table").array()
        } catch {
            print("error with getChildTables() \(error)")
            return nil
        }
    }
    
    
    private func getChildTablesCells(childTables: [Element]) -> [Element] {
        var childTablesCells: [Element] = []
        do {
            for table in childTables {
                childTablesCells.append(contentsOf: try table.select("td").array())
            }
        } catch {
            print("Error with getChildTablesCells() \(error)")
        }
        return childTablesCells
    }
    
    private func getFormatFromCell(cell: Element) -> String {
        do {
            let stringArray = try cell.text().components(separatedBy: "/")
            let format = stringArray[1]
            return format
        } catch {
            return ""
        }
    }
    
    private func getLocationFromCell(cell: Element) -> String {
        var location = ""
        do {
            let locationsArray = try cell.text().components(separatedBy: ",")
            if locationsArray.count == 1 {
                let stringArray = locationsArray[0].components(separatedBy: "/")
                location = stringArray[1]
            } else {
                for eachLocation in locationsArray {
                    let stringArray = eachLocation.components(separatedBy: "/")
                    if eachLocation == locationsArray.last {
                        location = location + stringArray[1]
                    } else {
                    location = location + stringArray[1] + ", "
                    }
                }
            }
        } catch {
        }
        return location
    }
    
    private func getStaffMemberFromCell(cell: Element) -> String {
        do {
            let staffMember = try cell.text()
            return staffMember
        } catch {
            return ""
        }
    }
    
    private func sortModuleDetailsByTime(moduleDetails: [ModuleDetail]) -> [ModuleDetail] {
        let sortedArray = moduleDetails.sorted(by: {
            $0.timeIndex < $1.timeIndex})
        return sortedArray
    }
}
