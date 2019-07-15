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
    var navDrawerShowing: Bool {get}
}

class MainMenuViewController: UIViewController{
    
    // MARK: - Declarations
    
    @IBOutlet weak var mainMenuCollectionView: UICollectionView!
    @IBOutlet weak var mainMenuVisualEffectView: UIVisualEffectView!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuCollectionView.dataSource = self
        mainMenuCollectionView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.menuOption = sender as? MenuOption
        }
    }
    
    // MARK: - Navigation Bar Actions
    var delegate: MainMenuViewControllerDelegate?
    
    @IBAction func menuToggle(_ sender: Any) {
       delegate?.toggleNavDrawer()
    }
    @IBAction func swipeRight(_ sender: Any) {
        if !delegate!.navDrawerShowing {
            delegate?.toggleNavDrawer()
        }
    }
    @IBAction func swipeLeft(_ sender: Any) {
        if delegate!.navDrawerShowing {
            delegate?.toggleNavDrawer()
        }
    }
}

// MARK: - Collection View Layout
extension MainMenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MenuOption.menuOptions().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCollectionViewCell
        let menuOptions = MenuOption.menuOptions()
        cell.imageView.image = menuOptions[indexPath.item].image
        cell.label.text = menuOptions[indexPath.item].label
        
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = CGFloat(0.5)
        cell.layer.cornerRadius = CGFloat(10)
        
        return cell
    }
    
}


// MARK: - Collection View Actions
extension MainMenuViewController: UICollectionViewDelegate {
    //Selects the view controller to navigate to based on which cell in the collection view was selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuOption = MenuOption.menuOptions()[indexPath.row]
        performSegue(withIdentifier: "menuToWebPage", sender: menuOption)
    }
}

extension MainMenuViewController: NavDrawerViewControllerDelegate {
}
