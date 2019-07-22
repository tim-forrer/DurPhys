//
//  HomeworkViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 21/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class HomeworkViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeworkToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func problemSolvingStrategiesPressed(_ sender: Any) {
        let option = Option.nilOption()
        option.url = "https://www.csun.edu/science/courses/525/old_files/thinking/probsolv_physics.htm"
        performSegue(withIdentifier: "homeworkToWebPage", sender: option)
    }
    
    @IBAction func instructionsForWeeklyProblemsPressed(_ sender: Any) {
        let option = Option.nilOption()
        option.url = "https://www.dur.ac.uk/resources/physics/students/level1weeklyproblems.pdf"
        performSegue(withIdentifier: "homeworkToWebPage", sender: option)
    }
    @IBAction func tenStepsPressed(_ sender: Any) {
        let option = Option.nilOption()
        option.url = "https://www.smarterthanthat.com/physics/physics-dont-panic-10-steps-to-solving-most-physics-problems/"
        performSegue(withIdentifier: "homeworkToWebPage", sender: option)
    }
    
}
