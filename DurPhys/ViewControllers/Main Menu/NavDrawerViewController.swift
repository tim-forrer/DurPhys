//
//  NavigationDrawerViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 11/07/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import MessageUI
import KeychainSwift

class NavDrawerViewController: UITableViewController {
    
    // MARK: - Declarations
    let keychain = KeychainSwift()
    let navOptions = Option.navOptions()
    
    @IBOutlet weak var navDrawerTableView: UITableView!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.keychain.get("username") ?? "none set")
        tableViewStyle()
        loginButtonStyle()
        
    }
    
    // MARK: - Customisation
    func tableViewStyle() {
        navDrawerTableView.layer.masksToBounds = false
        navDrawerTableView.layer.shadowColor = UIColor.black.cgColor
        navDrawerTableView.layer.shadowRadius = 20.0
        navDrawerTableView.layer.shadowOpacity = 1.0
        navDrawerTableView.layer.shadowOffset = .zero
    }
    
    func loginButtonStyle() {
        loginButton.layer.cornerRadius = 10
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.titleLabel?.adjustsFontSizeToFitWidth = true
        loginButton.titleLabel?.numberOfLines = 2
        loginButton.titleLabel?.textAlignment = .center
        if Utils.isLoggedIn() {
            loginButton.setTitle("Logged In", for: .normal)
        } else {
            loginButton.setTitle("Log In", for: .normal)
        }
    }
    
    //MARK: - Setup of TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        var sections: [String] = []
        for section in navOptions {
            for item in section {
                if !sections.contains(item.section!) {
                    sections.append(item.section!)
                }
            }
        }
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
        var sections: [String] = []
        for section in navOptions {
            for item in section {
                if !sections.contains(item.section!) {
                    sections.append(item.section!)
                }
            }
        }
        
        var itemsInSection: Int = 0
        for section in navOptions {
            for item in section {
                if item.section == sections[sectionIndex] {
                    itemsInSection += 1
                }
            }
        }
        return itemsInSection
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sections: [String] = []
        for section in navOptions {
            for item in section {
                if !sections.contains(item.section!) {
                    sections.append(item.section!)
                }
            }
        }
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "navDrawerCell", for: indexPath)

        cell.imageView?.image = navOptions[indexPath.section][indexPath.row].image
        cell.imageView?.tintColor = UIColor(red: 104/255, green: 36/255, blue: 109/255, alpha: 1.0)
        
        cell.textLabel?.text = navOptions[indexPath.section][indexPath.row].label
        
        return cell
    }
    
    
    // MARK: - Actions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navDrawerToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        func getNavOption() -> Option {
            for section in navOptions {
                for item in section {
                    if item.label == cell?.textLabel?.text {
                        return item
                    }
                }
            }
            return navOptions[0][0] //just a random default value so there is a return outside of the nested loops, this should never be called
        }
        let navOption = getNavOption()
        if navOption.section != "General" {
            performSegue(withIdentifier: "navDrawerToWebPage", sender: navOption)
        } else if navOption.label == "Report Bugs" {
            showMailComposer()
        } //else display the about page
        
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        if Utils.isLoggedIn() {
            logOut()
        } else {
            handleLogin()
        }
    }
    
}

// MARK: - Mail Composer Delegate
extension NavDrawerViewController: MFMailComposeViewControllerDelegate {
    
    func showMailComposer() {
        
        guard MFMailComposeViewController.canSendMail() else {
            //Show an alert to say your device can't send emails
            present(self.defaultAlert(title: "Cannot Display Email Composer", message: "Your device's email preferences have not been setup/have been setup incorrectly."), animated: true)
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["physics.app@durham.ac.uk"])
        composer.setSubject("Physics App Bug Report")
        composer.setMessageBody("", isHTML: false)
        UIApplication.shared.keyWindow?.rootViewController?.present(composer, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            //Show error alert
            controller.dismiss(animated: true)
            return
        }
        switch result {
        case .failed:
            let emailFailed = self.defaultAlert(title: "Error", message: "There was an error when sending your email. That's unfortunate as I assume you were about to email us regarding a separate issue. Please manually email physics.app@durham.ac.uk and we'll try to resolve your issue as best we can. Well, issues now.")
            self.present(emailFailed, animated: true)
            controller.dismiss(animated: true)
        default:
            controller.dismiss(animated: true)
        }
    }
}


// MARK: - Login functions
extension NavDrawerViewController {
    
    func defaultAlert(title: String, message: String) -> UIAlertController{
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
    }
    
    func handleLogin() {
        
        let loginPopUp = UIAlertController(title: "Login", message: "Please login using your CIS credentials", preferredStyle: .alert)
        loginPopUp.addTextField(configurationHandler: {textField in
            textField.placeholder = "Username"
        })
        loginPopUp.addTextField(configurationHandler: {textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        })
        loginPopUp.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        loginPopUp.addAction(UIAlertAction(title: "Login", style: .default, handler: {action in
            self.keychain.set((loginPopUp.textFields?[0].text)!, forKey: "username")
            self.keychain.set((loginPopUp.textFields?[1].text)!, forKey: "password")
            if self.credentialsBlank(username: self.keychain.get("username")!, password: self.keychain.get("password")!) {
                return
            } else {
                self.performLogin()
            }
            }
        ))
        
        self.present(loginPopUp, animated: true)
    }
    
    func credentialsBlank(username: String, password: String) -> Bool {
        if username.isEmpty && password.isEmpty {
            let alert = defaultAlert(title: "Username and Password blank.", message: "You cannot leave the username and password fields blank. Please enter your CIS credentials.")
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            return true
        }
        return false
    }
    
    func performLogin() {
        var request = URLRequest(url: URL(string: "https://timetable.dur.ac.uk")!)
        
        request.httpMethod = "GET"
        
        let headerValue = self.keychain.get("username")! + ":" + self.keychain.get("password")!
        let utfHeaderValue = headerValue.data(using: .utf8, allowLossyConversion: false)
        let base64HeaderValue = utfHeaderValue?.base64EncodedString()
        let finalHeaderValue = "Basic " + base64HeaderValue!
        request.setValue(finalHeaderValue, forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            print("statusCode should be 200, but is \(httpStatus!.statusCode)")
            
            if httpStatus!.statusCode != 200 {
                let loginError = self.defaultAlert(title: "Login Error", message: "There was an error whilst logging in. Please try again.")
                self.present(loginError, animated: true)
            } else {
                DispatchQueue.main.async {
                    let loginSuccess = self.defaultAlert(title: "Login Successful", message: "You have logged in successfully as \(String(describing: self.keychain.get("username")!))")
                    self.present(loginSuccess, animated: true)
                    self.loginButton.setTitle("Logged in", for: .normal)
                }
            }

            
        }
        task.resume()
    }
    
    func logOut() {
        self.loginButton.setTitle("Login", for: .normal)
        keychain.clear()
        let logOutSuccess = self.defaultAlert(title: "Logout Successful", message: "You have successfully logged out")
        self.present(logOutSuccess, animated: true)
    }
    
    
}
