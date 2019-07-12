//
//  ContainerViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 11/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    var navDrawerShowing = false
    
    var mainMenuNavigationController: UINavigationController!
    var mainMenuViewController: MainMenuViewController!
    var navDrawerViewController: NavDrawerViewController?
    
    let centerPanelExpandedOffset: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuViewController = UIStoryboard.mainMenuViewController()
        mainMenuViewController.delegate = self
        
        // wrap the mainMenuViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        mainMenuNavigationController = UINavigationController(rootViewController: mainMenuViewController)
        view.addSubview(mainMenuNavigationController.view)
        addChild(mainMenuNavigationController)
        
        mainMenuNavigationController.didMove(toParent: self)
    }
}

private extension UIStoryboard {
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    static func navDrawerViewController() -> NavDrawerViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "navDrawerViewController") as? NavDrawerViewController
    }
    
    static func mainMenuViewController() -> MainMenuViewController? {
        return mainStoryboard().instantiateViewController(withIdentifier: "mainMenuViewController") as? MainMenuViewController
    }
}

// MARK: - MainMenuViewController delegate

extension ContainerViewController: MainMenuViewControllerDelegate {
    
    func toggleNavDrawer(){
        if !navDrawerShowing {
            addNavDrawerViewController()
        }
        let shouldExpand = !navDrawerShowing
        animateNavDrawer(shouldExpand: shouldExpand)
        showShadowForMainMenuViewController(shouldExpand)
        navDrawerShowing = !navDrawerShowing
    }
    
    func addNavDrawerViewController() {
        guard navDrawerViewController == nil else { return }
        
        if let vc = UIStoryboard.navDrawerViewController() {
            addChildSidePanelController(vc)
            navDrawerViewController = vc
        }
    }
    
    func animateNavDrawer(shouldExpand: Bool) {
        if shouldExpand {
            animateCenterPanelXPosition(targetPosition: mainMenuNavigationController.view.frame.width - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.navDrawerViewController?.view.removeFromSuperview()
                self.navDrawerViewController = nil
            }
        }
    }

    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.mainMenuNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func addChildSidePanelController(_ navDrawerController: NavDrawerViewController) {
        //navDrawerController.delegate = mainMenuViewController
        view.insertSubview(navDrawerController.view, at: 0)
        
        addChild(navDrawerController)
        navDrawerController.didMove(toParent: self)
    }
    
    func showShadowForMainMenuViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            mainMenuNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            mainMenuNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}
