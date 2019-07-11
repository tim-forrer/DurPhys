//
//  PhysicsPortalViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 09/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import WebKit

class PhysicsPortalViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Declarations
    var webView: WKWebView!
    
    
    // MARK: - Init
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://teaching.physics.dur.ac.uk")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }
}
