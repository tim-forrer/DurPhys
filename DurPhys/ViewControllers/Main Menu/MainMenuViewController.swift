//
//  MainMenuViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 09/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import KeychainSwift

// MARK: - MainMenuViewControllerDelegate
protocol MainMenuViewControllerDelegate {
    func toggleNavDrawer()
    var navDrawerShowing: Bool {get}
}

class MainMenuViewController: UIViewController{
    
    // MARK: - Declarations
    var delegate: MainMenuViewControllerDelegate?
    var keychain = KeychainSwift()
    
    @IBOutlet weak var mainMenuCollectionView: UICollectionView!
    @IBOutlet weak var backgroundView: UIView!
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        mainMenuCollectionView.dataSource = self
        mainMenuCollectionView.delegate = self
        
        showLoginPromptIfNeeded()
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menuToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }
    
    // MARK: - Navigation Bar Actions
    @IBAction func menuToggle(_ sender: Any) {
       delegate?.toggleNavDrawer()
    }
}

// MARK: - Collection View Layout
extension MainMenuViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Option.menuOptions().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainMenuCell", for: indexPath) as! MainMenuCollectionViewCell
        let menuOptions = Option.menuOptions()
        cell.imageView.image = menuOptions[indexPath.item].image
        cell.imageView.tintColor = Utils.palatinate
        cell.label.text = menuOptions[indexPath.item].label
        
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = CGFloat(0.5)
        cell.layer.cornerRadius = CGFloat(10)
        
        return cell
    }
    
}


// MARK: - Collection View Actions
extension MainMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let menuOption = Option.menuOptions()[indexPath.row]
        
        if menuOption.url != nil {
            performSegue(withIdentifier: "menuToWebPage", sender: menuOption)
        } else if menuOption.name != "courseInformation" || Utils.isLoggedIn() {
            let nextStoryboard = UIStoryboard(name: menuOption.label!, bundle: nil)
            let newViewController = nextStoryboard.instantiateViewController(withIdentifier: menuOption.label!)
            newViewController.title = menuOption.label
            navigationController?.pushViewController(newViewController, animated: true)
        } else {
            showLoginPromptIfNeeded()
        }
    }
}

// MARK: - Logged in check
extension MainMenuViewController {
    
    func loginPrompt() -> UIAlertController {
        let alert = UIAlertController(title: "User not logged in.", message: "You are not logged in, many sections of this app require you to be logged in for full functionality.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in self.delegate?.toggleNavDrawer()}))
        return alert
    }
    
    func showLoginPromptIfNeeded() {
        if !Utils.isLoggedIn() {
            self.parent!.present(loginPrompt(), animated: true)
        }
    }
}

