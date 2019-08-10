//
//  Module.swift
//  DurPhys
//
//  Created by Tim Forrer on 04/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import Foundation

class Module {
    
    let name: String
    let code: Int
    let dept: String
    let fullCode: String
    
    init(name: String, code: Int, dept: String) {
        self.name = name
        self.code = code
        self.dept = dept //separated code and dept in case sorting by department was desired at some stage
        self.fullCode = dept + String(code)
    }
    
    class func modules() -> [Module] {
        var modules = [Module]()
        
        let introToAstro = Module(name: "Introduction To Astronomy", code: 1081, dept: "PHYS")
        let foundationsOfPhys = Module(name: "Foundations of Physics 1", code: 1122, dept: "PHYS")
        let discSkillsInPhys = Module(name: "Discovery Skills in Physics", code: 1101, dept: "PHYS")
        let mathsTookit = Module(name: "Maths Toolkit for Scientists", code: 1141, dept: "PHYS")
        
        let sma = Module(name: "Single Mathematics A", code: 1561, dept: "MATH")
        let smb = Module(name: "Single Mathematics B", code: 1571, dept: "MATH")
        let analysis = Module(name: "Analysis I", code: 1051, dept: "MATH")
        let calculus = Module(name: "Calculus I", code: 1061, dept: "MATH")
        let linAlg = Module(name: "Linear Algebra I", code: 1071, dept: "MATH")
        
        modules.append(introToAstro)
        modules.append(foundationsOfPhys)
        modules.append(discSkillsInPhys)
        modules.append(mathsTookit)
        modules.append(sma)
        modules.append(smb)
        modules.append(analysis)
        modules.append(calculus)
        modules.append(linAlg)
        
        return modules
    }
}
