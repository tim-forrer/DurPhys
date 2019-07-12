//
//  WebPageViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 11/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Declarations
    var webView: WKWebView!
    
    var labelText: String?
    
    
    // MARK: - Init
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://duo.dur.ac.uk")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }
}
