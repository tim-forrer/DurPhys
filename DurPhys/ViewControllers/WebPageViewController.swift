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
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    var option: Option!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if option.loginPossible {
            navBar.isHidden = true
            
        } else {
            navigationController?.setNavigationBarHidden(true, animated: false)
            
            navBarTitle.title = option.label
            let navBarAppearance = UINavigationBar.appearance()
            navBarAppearance.barTintColor = Utils.palatinate
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
        }
        
        webView.navigationDelegate = self
        let url = URL(string: option.url!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
        
        if option.loginPossible {
            print("Attempting login")
        }
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true) {
        }
    }
}
