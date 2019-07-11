//
//  MainMenuViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 09/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController{
    
    // MARK: - Declarations
    
    let mainMenuOptions = [
        "Getting Around",
        "Course Information (Weekly Timetables)",
        "Important Contacts",
        "Teaching Formats",
        "Physics Portal (Homework Hand-In)",
        "University Email",
        "D.U.O."
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
        let imageView = cell.mainMenuImage!
        let label = cell.mainMenuLabel!
        
        imageView.image = mainMenuImages[indexPath.item]
        imageView.frame.size.height = cell.frame.size.width - 5
        imageView.frame.size.width = cell.frame.size.width - 10
        
        cell.mainMenuLabel.text = mainMenuOptions[indexPath.item]
        let labelText = cell.mainMenuLabel!
        label.frame.size.height = Utils.heightForView(text: labelText.text!, font: labelText.font!, width: cell.frame.width)
        label.frame.size.width = cell.frame.size.width
        label.center.x = cell.frame.size.width / 2
        label.center.y = cell.mainMenuImage.frame.size.height + (cell.frame.size.height - cell.mainMenuImage.frame.size.height) / 2
        
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = CGFloat(0.5)
        cell.layer.cornerRadius = CGFloat(10)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCollectionViewCell
        let padding: CGFloat = 40
        let cellWidth = (collectionView.frame.size.width - padding) / 2
        let labelText = mainMenuOptions[indexPath.item]
        let cellHeight = cellWidth + Utils.heightForView(text: labelText, font: cell.mainMenuLabel.font!, width: cell.frame.width) + 70
        
        return CGSize(width: cellWidth, height: cellHeight)
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

extension MainMenuViewController: NavigationDrawerViewControllerDelegate{
}

protocol MainMenuViewControllerDelegate {
    func toggleNavDrawer()
}
