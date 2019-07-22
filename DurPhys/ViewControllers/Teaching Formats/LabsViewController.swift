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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "labsToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.youtube.com/embed/5Zl9Fahrz6s")!

        webView.load(URLRequest(url: url))
        
        
    }
    
    @IBAction func labsPressed(_ sender: Any) {
        let option = Option.nilOption()
        option.url = "https://www.dur.ac.uk/physics/students/labs/level1/"
        performSegue(withIdentifier: "labsToWebPage", sender: option)
    }
}
