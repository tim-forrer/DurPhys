//
//  MainMenuViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 09/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

protocol MainMenuViewControllerDelegate {
    func toggleNavDrawer()
}

class MainMenuViewController: UIViewController{
    
    // MARK: - Declarations
    
    let mainMenuOptions = [
        "Getting Around",
        "Course Information (Weekly Timetables)",
        "Important Contacts",
        "Teaching Formats",
        "Physics Portal (Homework Hand-In)",
        "University Email",
        "D.U.O.",
    ]
    
    let mainMenuImages: [UIImage] = [
        UIImage(named: "gettingAround")!,
        UIImage(named: "courseInformation")!,
        UIImage(named: "importantContacts")!,
        UIImage(named: "teachingFormats")!,
        UIImage(named: "physicsPortal")!,
        UIImage(named: "universityEmail")!,
        UIImage(named: "duo")!,
    ]
    
    @IBOutlet weak var mainMenuCollectionView: UICollectionView!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuCollectionView.dataSource = self
        mainMenuCollectionView.delegate = self
    }
    
    // MARK: - ADD NAVDRAW STUFF (Might need to delete)
    var delegate: MainMenuViewControllerDelegate?
    
    @IBAction func menuToggle(_ sender: Any) {
       delegate?.toggleNavDrawer()
    }
    
}

// MARK: - Layout
extension MainMenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainMenuOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCollectionViewCell
        cell.imageView.image = mainMenuImages[indexPath.item]
        cell.label.text = mainMenuOptions[indexPath.item]
        
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = CGFloat(0.5)
        cell.layer.cornerRadius = CGFloat(10)
        
        return cell
    }
    
}


// MARK: - Actions
extension MainMenuViewController: UICollectionViewDelegate {
    //Selects the view controller to navigate to based on which cell in the collection view was selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewControllerName = mainMenuOptions[indexPath.item]
        var newStoryboard = UIStoryboard()
        switch viewControllerName {
        case "Getting Around":
            newStoryboard = UIStoryboard(name: "GettingAround", bundle: nil)
        case "Course Information (Weekly Timetables)":
            newStoryboard = UIStoryboard(name: "CourseInformation", bundle: nil)
        case "Important Contacts":
            newStoryboard = UIStoryboard(name: "ImportantContacts", bundle: nil)
        case "Teaching Formats":
            newStoryboard = UIStoryboard(name: "TeachingFormats", bundle: nil)
        case "Physics Portal (Homework Hand-In)", "University Email", "D.U.O.":
            newStoryboard = UIStoryboard(name: "BrowserScreens", bundle: nil)
        default:
            print("uh-oh, we're in trouble")
        }
        let newViewController = newStoryboard.instantiateViewController(withIdentifier: viewControllerName)
        navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension MainMenuViewController: NavDrawerViewControllerDelegate{
}
