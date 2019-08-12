//
//  PlaceDetailsQuery.swift
//  DurPhys
//
//  Created by Tim Forrer on 12/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation
import SwiftSoup

class PlaceDetailsQuery {
    
    func getPlaceDetailsJSON(placeID: String, completionHandle: @escaping(String) -> Void) {
        let baseURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid="
        let queryParams = ""
        let url = URL(string: baseURL + placeID + queryParams)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        
        let defaultSession = URLSession(configuration: .default)
        var errorMessage: String = ""
        
        let dataTask = defaultSession.dataTask(with: request) { data, response, error in
            
        }
        
        dataTask.resume()
        
        
        
    }
    
}
