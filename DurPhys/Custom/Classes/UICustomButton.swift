//
//  UICustomButton.swift
//  DurPhys
//
//  Created by Tim Forrer on 22/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class UICustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        titleLabel?.adjustsFontSizeToFitWidth = true
        setStyle()
    }
    
    func setStyle() {
        backgroundColor = Utils.palatinate
        layer.cornerRadius = 5.0
        tintColor = .white
    }
}
