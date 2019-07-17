//
//  LoginViewController.swift
//  DurPhys
//
//  Created by Tim on 15/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Declarations
    var webView: WKWebView!
    var option: Option!
    
    
    
    // MARK: - Init
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: option.url!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
        
        if option.loginPossible {
            print("Attempting login")
        }
    }
    
    
    
}
