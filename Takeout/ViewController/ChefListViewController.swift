//
//  ChefListViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-06.
//  Copyright © 2018 fred. All rights reserved.
//

//IMPORTANT: NEED TO MAKE SURE USER IS FIRST LOGED IN!!!!!!

import UIKit
import MapKit

class ChefListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var chefTableView: UITableView!
    var chefs = [Chef]()
    var menus = [Menu]()
    let locationOptions = ["Home Location", "Work Location"]
    
    override func viewDidLoad() {
        guard chefTableView != nil else { return }
        super.viewDidLoad()
        //NOTE: REMOVE THIS LOGIN PART LATER!! JUST FOR TESTING/DEMO
        let location = UserManager.sharedInstance.selectedLocation
        let type = UserManager.sharedInstance.selectedType
        self.getChefs(type: type, limit: 10, longitude: location.longitude, latitude: location.latitude)
        let locationPickerView = UIPickerView()
        locationInput.delegate = self
        chefTableView.delegate = self
        chefTableView.dataSource = self
        locationPickerView.delegate = self
        locationInput.inputView = locationPickerView
        resetLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetLocation()
    }
    
    func resetLocation() {
        if (UserManager.sharedInstance.selectedLocation.address != "") {
            locationInput.text = UserManager.sharedInstance.selectedLocation.address
        } else {
            locationInput.text = "Please Select Your Location"
        }
    }
    @IBAction func endEditing(_ sender: Any) {
        view.endEditing(true)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chefs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chef = chefs[(chefTableView.indexPathForSelectedRow?.row)!]
        RestAPIManager.sharedInstance.get_menus(id: chef._id, onSuccess:{
            (menus: [Menu]) in print("Successful")
            self.menus = menus
            DispatchQueue.main.sync {
                self.view.endEditing(true)
                self.performSegue(withIdentifier: "showDishList", sender: self)
            }
        }, onFailure: {_ in
            DispatchQueue.main.sync {
                self.view.endEditing(true)
                print("get_menus Failed")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DishListViewController {
            let chef = chefs[(chefTableView.indexPathForSelectedRow?.row)!]
            destination.chef = chef
            destination.menus = self.menus
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chefTableCell") as! ChefTableViewCell
        let chef = chefs[indexPath.row]
        //Of course, need to change this later....
        cell.chefName.text = chef.name
        cell.chefPrice.text = "\((chef.paymentRatio)!)"
        cell.chefDistance.text = "\((chef.distance)!)" + " Km"
        return cell
    }
    
    func getChefs(type: String, limit: Int, longitude: Double, latitude: Double) {
        RestAPIManager.sharedInstance.get_chefs(type: type, limit: limit, longitude: longitude, latitude: latitude, onSuccess: {(chefList: [Chef]) in
            DispatchQueue.main.async {
                self.chefs = chefList
                self.setDistance()
                self.chefTableView.reloadData()
            }
        }, onFailure: {_ in
            DispatchQueue.main.async {
                print("chefList failed")
            }
        })
    }
    
    func setDistance() {
        let userLocation = UserManager.sharedInstance.selectedLocation
        guard  userLocation.address != "" else { return }
        if(userLocation.address != "") {
            for i in 0..<chefs.count {
                guard chefs[i].location?.address != "" else { continue }
                let userLocationCoord = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
                let chefLocationCoord = CLLocation(latitude: (chefs[i].location?.latitude)!, longitude:(chefs[i].location?.longitude)!)
                let distance = (userLocationCoord.distance(from: chefLocationCoord) / 1000)
                let distanceRound = Double(round(10*distance)/10)
                chefs[i].distance = distanceRound
            }
        }
    }
    
    func updateLocation(location: Location) {
        getChefs(type:"Chinese", limit: 10, longitude: location.longitude, latitude: location.latitude)
    }
    
    func updateType(type: String) {
        getChefs(type:type, limit: 10, longitude: 100, latitude: 200)
    }
    
    func updateLimit(limit: Int) {
        getChefs(type:"Chinese", limit: limit, longitude: 100, latitude: 200)
    }
}

extension ChefListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ChefListViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let option = locationOptions[row]
        
        let oldAddress = UserManager.sharedInstance.selectedLocation.address
        
        if option == "Home Location" {
            let homeLocation = UserManager.sharedInstance.user.homeLocation
            guard homeLocation != nil else {
                locationInput.text = "Please add home address in setting"
                view.endEditing(true)
                return
            }
            locationInput.text = (homeLocation?.address)!
            UserManager.sharedInstance.selectHomeLocation()
            if(oldAddress != homeLocation?.address) {
                let location = UserManager.sharedInstance.selectedLocation
                let type = UserManager.sharedInstance.selectedType
                self.getChefs(type: type, limit: 10, longitude: location.longitude, latitude: location.latitude)
            }
        }
        
        else if option == "Work Location" {
            let workLocation = UserManager.sharedInstance.user.workLocation
            guard workLocation != nil else {
                locationInput.text = "Please add work address in setting"
                view.endEditing(true)
                return
            }
            locationInput.text = (workLocation?.address)!
            UserManager.sharedInstance.selectWorkLocation()
            if(oldAddress != workLocation?.address) {
                let location = UserManager.sharedInstance.selectedLocation
                let type = UserManager.sharedInstance.selectedType
                self.getChefs(type: type, limit: 10, longitude: location.longitude, latitude: location.latitude)
            }
        }
        view.endEditing(true)
    }
}
