//
//  temp.swift
//  DurPhys
//
//  Created by Tim Forrer on 08/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation
import KeychainSwift

class CourseInfoQueryTemp{
    
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
}
