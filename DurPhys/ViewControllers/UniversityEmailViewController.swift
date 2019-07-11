//
//  UniversityEmailViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 09/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import WebKit

class UniversityEmailViewController: UIViewController, WKNavigationDelegate {
    
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
        
        let url = URL(string: "https://adfs.durham.ac.uk/adfs/ls/?wa=wsignin1.0&wtrealm=urn:federation:MicrosoftOnline&wctx=wa%3Dwsignin1.0%26rpsnv%3D4%26ct%3D1435155873%26rver%3D6.6.6556.0%26wp%3DMBI_SSL%26wreply%3Dhttps:%252F%252Foutlook.office365.com%252Fowa%252F%253Frealm%253Ddurham.ac.uk%2526authRedirect%253Dtrue%26id%3D260563%26whr%3Ddurham.ac.uk%26CBCXT%3Dout")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }
}

