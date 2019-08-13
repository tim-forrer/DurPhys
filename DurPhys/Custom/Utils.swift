//
//  Utils.swift
//  DurPhys
//
//  Created by Tim Forrer on 11/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import KeychainSwift

class Utils: UIViewController {
    
    static let palatinate = UIColor(red: 104/255, green: 36/255, blue: 109/255, alpha: 1.0)
    static let heather = UIColor(red: 203/255, green: 168/255, blue: 177/255, alpha: 1.0)
    static let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    
    class func isLoggedIn() -> Bool {
        let keychain = KeychainSwift()
        return (keychain.get("username") != nil) && (keychain.get("password") != nil)
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
    
    var last: Element {
        return self[self.count - 1]
    }
}

extension UIStoryboard {
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func navDrawerViewController() -> NavDrawerViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "navDrawerViewController") as? NavDrawerViewController
    }
    
    static func mainMenuViewController() -> MainMenuViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "mainMenuViewController") as? MainMenuViewController
    }
}
