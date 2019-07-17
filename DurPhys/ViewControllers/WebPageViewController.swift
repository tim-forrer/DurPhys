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
    @IBOutlet weak var webView: WKWebView!
    
    var option: Option!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        let url = URL(string: option.url!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
        
        if option.loginPossible {
            print("Attempting login")
        }
    }
    
    
}
