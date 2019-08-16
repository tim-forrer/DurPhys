//
//  FoodAndDrinkViewController.swift
//  DurPhys
//
//  Created by Tim Forrer on 14/08/2019.
//  Copyright © 2019 Durham University Physics Department. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

struct FoodCellData {
    var isOpen: Bool
    let data: Place
}

class FoodAndDrinkViewController: UIViewController {
    
    let foodPlaces = Place.getFoodPlaces()
    lazy var foodCellData = generateTableViewCellData()
    let locationManager = CLLocationManager()

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodAndDrinkToWebPage" {
            let destVC = segue.destination as! WebPageViewController
            destVC.option = sender as? Option
        }
    }
    
    func generateTableViewCellData() -> [FoodCellData] {
        var tableViewCellData: [FoodCellData] = []
        for foodPlace in foodPlaces {
            let cellData = FoodCellData(isOpen: false, data: foodPlace)
            tableViewCellData.append(cellData)
        }
        return tableViewCellData
    }
}

extension FoodAndDrinkViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodPlaces.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle(foodPlaces[section].name, for: .normal)
        setButtonStyle(button: button)
        button.tag = section
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if foodCellData[section].isOpen {
            return 1
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodAndDrinkCell") as! FoodAndDrinkTableViewCell
        cell.tag = indexPath.section
        setupCell(cell: cell)
        
        return cell
    }
    
    
}

// MARK: - Header Button Setup
extension FoodAndDrinkViewController {
    
    func setButtonStyle(button: UIButton) {
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.contentHorizontalAlignment = .left
        button.tintColor = .white
        button.backgroundColor = Utils.palatinate
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 10
    }
    
    
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        let indexPath = [IndexPath(row: 0, section: section)]
        if foodCellData[section].isOpen {
            foodCellData[section].isOpen = !foodCellData[section].isOpen
            tableView.deleteRows(at: indexPath, with: .fade)
            button.contentHorizontalAlignment = .left
        } else {
            foodCellData[section].isOpen = !foodCellData[section].isOpen
            tableView.insertRows(at: indexPath, with: .fade)
            button.contentHorizontalAlignment = .center
        }
        
    }

}

// MARK: - Cell setup

extension FoodAndDrinkViewController {
    
    func setupCell(cell: FoodAndDrinkTableViewCell) {
        let currentPlace = foodPlaces[cell.tag]
        cell.monday.text = "Monday: " + currentPlace.openingTimes![0]
        cell.tuesday.text = "Tuesday: " + currentPlace.openingTimes![1]
        cell.wednesday.text = "Wednesday: " + currentPlace.openingTimes![2]
        cell.thursday.text = "Thursday: " + currentPlace.openingTimes![3]
        cell.friday.text = "Friday: " + currentPlace.openingTimes![4]
        cell.saturday.text = "Saturday: " + currentPlace.openingTimes![5]
        cell.sunday.text = "Sunday: " + currentPlace.openingTimes![6]
        boldTextDay(cell: cell)
        
        cell.callButton.tag = cell.tag
        cell.callButton.addTarget(self, action: #selector(didTapCallButton), for: .touchUpInside)
        cell.callButton.tintColor = .blue
        
        cell.webButton.tag = cell.tag
        cell.webButton.addTarget(self, action: #selector(didTapWebsiteButton), for: .touchUpInside)
        cell.webButton.tintColor = .blue
        
        cell.mapButton.tag = cell.tag
        cell.mapButton.addTarget(self, action: #selector(didTapMapButton), for: .touchUpInside)
        cell.mapButton.tintColor = .blue
        
        if currentPlace.website == nil {
            cell.webButton.tintColor = .darkGray
        }
        if currentPlace.phone == nil {
            cell.callButton.tintColor = .darkGray
        }
    }
    
    func boldTextDay(cell: FoodAndDrinkTableViewCell) {
        let todaysDay = (Calendar.current.component(.weekday, from: Date()) - 2) % 7 //as the int it returns runs from 1-7 with 1 being Sunday, want to convert such that int runs from 0-6 and 0 is monday, just for consistency
        switch todaysDay {
        case 0:
            cell.monday.font = UIFont.boldSystemFont(ofSize: 17.0)
        case 1:
            cell.tuesday.font = UIFont.boldSystemFont(ofSize: 17.0)
        case 2:
            cell.wednesday.font = UIFont.boldSystemFont(ofSize: 17.0)
        case 3:
            cell.thursday.font = UIFont.boldSystemFont(ofSize: 17.0)
        case 4:
            cell.friday.font = UIFont.boldSystemFont(ofSize: 17.0)
        case 5:
            cell.saturday.font = UIFont.boldSystemFont(ofSize: 17.0)
        default:
            cell.sunday.font = UIFont.boldSystemFont(ofSize: 17.0)
        }
    }
    
    @objc func didTapCallButton(_ sender: UIButton) {
        print("tap call button")
    }
    
    @objc func didTapMapButton(_ sender: UIButton) {
        let place = foodPlaces[sender.tag]
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        let currentLocation = locationManager.location?.coordinate
        let source = MKMapItem(placemark: MKPlacemark(coordinate: currentLocation!))
        source.name = "Me"
        
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: Double(place.latitude!)!, longitude: Double(place.longitude!)!)))
        destination.name = place.name
        
        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking])
    }
    
    @objc func didTapWebsiteButton(_ sender: UIButton) {
        let place = foodPlaces[sender.tag]
        guard let _ = place.website else { return }
        let placeOption = Option(name: place.name, label: place.name, section: nil, url: place.website, image: nil, loginPossible: false)
        performSegue(withIdentifier: "foodAndDrinkToWebPage", sender: placeOption)
    }
    
}


extension FoodAndDrinkViewController: CLLocationManagerDelegate {
    
}
