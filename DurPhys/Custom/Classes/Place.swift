//
//  Place.swift
//  DurPhys
//
//  Created by Tim Forrer on 12/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation

class Place {
    var placeID: String
    var name: String?
    var latitude: String?
    var longitude: String?
    var openingTimes: [String: String]
    
    init(placeID: String, name: String?, latitude: String?, longitude: String?, openingTimes: [String: String]) {
        self.placeID = placeID
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.openingTimes = openingTimes
    }
    
    class func getPlaces() -> [Place] {
        var places: [Place] = []
        
        let paddys = Place(placeID: "ChIJI9LH3Il9fkgRYlAL0UX0EwE", name: nil, latitude: nil, longitude: nil, openingTimes: [String: String]())
        let tango = Place(placeID: "ChIJ27jm6Il9fkgRB1tsMiC-IsI", name: nil, latitude: nil, longitude: nil, openingTimes: [String: String]())
        let starbucks = Place(placeID: "ChIJ7TEw0Il9fkgRC_HFGgiQ99g", name: nil, latitude: nil, longitude: nil, openingTimes: [String: String]())
        let lebaneat = Place(placeID: "ChIJk7S592GHfkgR_EkB3peJpBI", name: nil, latitude: nil, longitude: nil, openingTimes: [String: String]())
        let cafeOnTheGreen = Place(placeID: "ChIJZ-md5WGHfkgRLQDDbHMA", name: nil, latitude: nil, longitude: nil, openingTimes: [String: String]())
        let waffley = Place(placeID: "ChIJtZ_854l9fkgRk05SX2U6Ryk", name: nil, latitude: nil, longitude: nil, openingTimes: [String: String]())
        
        places.append(paddys)
        places.append(tango)
        places.append(starbucks)
        places.append(lebaneat)
        places.append(cafeOnTheGreen)
        places.append(waffley)
        
        return places
    }
}
