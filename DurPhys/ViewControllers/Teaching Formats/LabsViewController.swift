//
//  LabsViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 21/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import WebKit

class LabsViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.youtube.com/embed/5Zl9Fahrz6s")!

        webView.load(URLRequest(url: url))
        
        
    }
    
}
