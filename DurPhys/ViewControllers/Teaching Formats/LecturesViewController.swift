//
//  LecturesViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 21/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import WebKit

class LecturesViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lecturesToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let url = URL(string: "https://www.youtube.com/embed/GdZegDRSzVE")!
        webView.load(URLRequest(url: url))
        
    }

    @IBAction func durhamBlogPressed(_ sender: Any) {
        let option = Option.nilOption()
        
        option.url = "https://community.dur.ac.uk/blogs/what-have-i-learned-in-my-first-year-at-uni-apart-from-physics/"
        
        performSegue(withIdentifier: "lecturesToWebPage", sender: option)
        
    }
    
    @IBAction func betterNotesPressed(_ sender: Any) {
        let option = Option.nilOption()
        
        option.url = "https://www.savethestudent.org/extra-guides/take-better-lecture-notes-8-easy-steps.html"

        performSegue(withIdentifier: "lecturesToWebPage", sender: option)
        
    }
    
}
