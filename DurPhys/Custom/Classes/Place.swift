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
    var openingTimes: [String]?
    var website: String?
    var phone: String?
    
    init(placeID: String, name: String?, latitude: String?, longitude: String?, openingTimes: [String]?, website: String?, phone: String?) {
        self.placeID = placeID
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.openingTimes = openingTimes
        self.website = website
    }
    
    class func getFoodPlaces() -> [Place] {
        var places: [Place] = []
        
        let paddys = Place(placeID: "ChIJI9LH3Il9fkgRYlAL0UX0EwE",
                           name: "Patrick's Pizza",
                           latitude: "54.775638",
                           longitude: "-1.572293",
                           openingTimes: ["18:00 - 03:00", "18:00 - 03:00", "18:00 - 03:00", "18:00 - 03:00", "18:00 - 03:00", "18:00 - 03:00", "18:00 - 03:00"],
                           website: nil,
                           phone: "01913741555")
        
        let tango = Place(placeID: "ChIJ27jm6Il9fkgRB1tsMiC-IsI",
                          name: "Tango Durham",
                          latitude: "54.775775",
                          longitude: "-1.573010",
                          openingTimes: ["11:00 - 21:30", "11:00 - 21:30", "11:00 - 21:30", "11:00 - 21:30", "11:00 - 21:30", "11:00 - 21:30", "11:00 - 21:30"],
                          website: "https://www.tangodurham.co.uk/menu/",
                          phone: "01913840096")
        
        let starbucks = Place(placeID: "ChIJ7TEw0Il9fkgRC_HFGgiQ99g",
                              name: "Starbucks",
                              latitude: "54.775667",
                              longitude: "-1.571761",
                              openingTimes: ["07:00 - 19:00", "07:00 - 19:00", "07:00 - 19:00", "07:00 - 20:30", "07:00 - 19:00", "08:00 - 17:00", "08:00 - 16:30"],
                              website: "https://www.starbuck.co.uk",
                              phone: "01913866821")
        
        let lebaneat = Place(placeID: "ChIJk7S592GHfkgR_EkB3peJpBI",
                             name: "Lebaneat",
                             latitude: "54.774856",
                             longitude: "-1.574657",
                             openingTimes: ["12:00 - 23:00", "12:00 - 23:00", "12:00 - 23:00", "12:00 - 23:00", "12:00 - 23:00", "12:00 - 23:00", "12:00 - 23:00"],
                             website: "https://www.lebaneat.co.uk",
                             phone: "01913846777")
        
        let cafeOnTheGreen = Place(placeID: "ChIJZ-md5WGHfkgRLQDDbHMA",
                                   name: "YUM Café on the Green",
                                   latitude: "54.774432",
                                   longitude: "-1.575472",
                                   openingTimes: ["09:00 - 16:00", "09:00 - 16:00", "09:00 - 16:00", "09:00 - 16:00", "09:00 - 16:00", "09:00 - 16:00", "09:00 - 16:00"],
                                   website: "https://www.yumfood.co.uk",
                                   phone: nil)
        
        let waffley = Place(placeID: "ChIJtZ_854l9fkgRk05SX2U6Ryk",
                            name: "Waffley Good Company",
                            latitude: "54.775757",
                            longitude: "-1.572826",
                            openingTimes: ["10:00 - 16:30", "Closed", "10:00 - 16:30", "10:00 - 16:30", "10:00 - 16:30", "10:00 - 16:30", "10:00 - 16:30", ],
                            website: nil,
                            phone: "01913840462")
        
        places.append(paddys)
        places.append(tango)
        places.append(starbucks)
        places.append(lebaneat)
        places.append(cafeOnTheGreen)
        places.append(waffley)
        
        return places
    }
    
    class func getNightlifePlaces() -> [Place] {
        var places: [Place] = []
        
        let klute = Place(placeID: "ChIJkSBUwol9fkgRSCue7fUuujI",
                          name: "Klute",
                          latitude: "54.776023",
                          longitude: "-1.573943",
                          openingTimes: nil,
                          website: nil,
                          phone: nil)
        
        let loft = Place(placeID: "ChIJH0RBxIp9fkgRuV5LKoN4PAM",
                         name: "Loft",
                         latitude: "54.776934",
                         longitude: "-1.580717",
                         openingTimes: nil,
                         website: nil,
                         phone: nil)
        
        let studio = Place(placeID: "ChIJH0RBxIp9fkgRuV5LKoN4PAM",
                         name: "Studio",
                         latitude: "54.777029",
                         longitude: "-1.580895",
                         openingTimes: nil,
                         website: nil,
                         phone: nil)
        
        let wiffWaff = Place(placeID: "ChIJEUgWRYp9fkgRxzJWksD1jL4",
                           name: "Wiff Waff",
                           latitude: "54.777263",
                           longitude: "-1.576562",
                           openingTimes: nil,
                           website: nil,
                           phone: nil)
        
        let jimmyAllens = Place(placeID: "ChIJ8zhK9Yl9fkgR04DzXpLy0gM",
                             name: "Jimmy Allens ",
                             latitude: "54.776143",
                             longitude: "-1.574161",
                             openingTimes: nil,
                             website: nil,
                             phone: nil)
        
        let fabios = Place(placeID: "ChIJpbT7GIp9fkgR3ZVg0nBh--w",
                             name: "Fabio's",
                             latitude: "54.776208",
                             longitude: "-1.575006",
                             openingTimes: nil,
                             website: nil,
                             phone: nil)
        
        let players = Place(placeID: "ChIJvzNfk059fkgR61MDK4zyug0",
                             name: "Players",
                             latitude: "54.777717",
                             longitude: "-1.575344",
                             openingTimes: nil,
                             website: nil,
                             phone: nil)
        
        places.append(klute)
        places.append(loft)
        places.append(studio)
        places.append(wiffWaff)
        places.append(jimmyAllens)
        places.append(fabios)
        places.append(players)
        
        return places
    }
}
