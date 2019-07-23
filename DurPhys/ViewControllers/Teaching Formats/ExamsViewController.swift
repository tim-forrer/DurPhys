//
//  ExamsViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 21/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import WebKit

class ExamsViewController: UIViewController {
    
    let option = Option.nilOption()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "examsToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://www.youtube.com/embed/dzYUf-0wXHw")!
        
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func examTechniquesPressed(_ sender: Any) {
        option.url = "https://www.dur.ac.uk/physics/students/exams/techniques/"
        performSegue(withIdentifier: "examsToWebPage", sender: option)
    }
    
    @IBAction func howToStudyPhysicsPressed(_ sender: Any) {
        option.url = "https://www.goconqr.com/en/examtime/blog/how-to-study-physics/"
        performSegue(withIdentifier: "examsToWebPage", sender: option)
    }
    
    @IBAction func howToPassPressed(_ sender: Any) {
        option.url = "https://www.dur.ac.uk/resources/physics/students/level1weeklyproblems.pdf"
        performSegue(withIdentifier: "examsToWebPage", sender: option)
    }
    
    
}
