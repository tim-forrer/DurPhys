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
    var option: Option!
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if option.loginPossible {
            navBar.isHidden = true
            self.title = option.label
            
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
        
    }
    
    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true) {}
    }
}
