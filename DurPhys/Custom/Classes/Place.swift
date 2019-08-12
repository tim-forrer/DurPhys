//
//  Place.swift
//  DurPhys
//
//  Created by Tim Forrer on 12/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation

class Place {
    var name: String
    var placeID: String
    var latitude: String?
    var longitude: String?
    var openingTimes: [String: String]
    
    init(name: String, placeID: String, latitude: String?, longitude: String?, openingTimes: [String: String]) {
        self.name = name
        self.placeID = placeID
        self.latitude = latitude
        self.longitude = longitude
        self.openingTimes = openingTimes
    }
    
    class func getPlaces() -> [Place] {
        var places: [Place] = []
        
        let paddys = Place(name: "Patrick's Pizza", placeID: "ChIJI9LH3Il9fkgRYlAL0UX0EwE", latitude: nil, longitude: nil, openingTimes: [String: String]())
        let tango = Place(name: "Tango", placeID: "ChIJ27jm6Il9fkgRB1tsMiC-IsI", latitude: nil, longitude: nil, openingTimes: [String: String]())
        let starbucks = Place(name: "Starbucks", placeID: "ChIJ7TEw0Il9fkgRC_HFGgiQ99g", latitude: nil, longitude: nil, openingTimes: [String: String]())
        let lebaneat = Place(name: "Lebaneat", placeID: "ChIJk7S592GHfkgR_EkB3peJpBI", latitude: nil, longitude: nil, openingTimes: [String: String]())
        let cafeOnTheGreen = Place(name: "Café On The Green", placeID: "ChIJZ-md5WGHfkgRLQDDbHMA", latitude: nil, longitude: nil, openingTimes: [String: String]())
        let waffley = Place(name: "Waffley Good Company", placeID: "ChIJtZ_854l9fkgRk05SX2U6Ryk", latitude: nil, longitude: nil, openingTimes: [String: String]())
        
        places.append(paddys)
        places.append(tango)
        places.append(starbucks)
        places.append(lebaneat)
        places.append(cafeOnTheGreen)
        places.append(waffley)
        
        return places
    }
}
