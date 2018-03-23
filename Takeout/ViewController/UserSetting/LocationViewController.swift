//
//  LocationViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-15.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var province: UITextField!
    @IBOutlet weak var output: UILabel!
    let activityIndicator = UIActivityIndicatorView()
    var isHome = true // true is home location, false is work location
    
    override func viewDidLoad() {
        super.viewDidLoad()
        country.delegate = self
        address.delegate = self
        city.delegate = self
        province.delegate = self
        output.isHidden = true
    }
    
    @IBAction func updateClick(_ sender: UIButton) {
        if((country.text?.isEmpty)! || (address.text?.isEmpty)! || (city.text?.isEmpty)! || (province.text?.isEmpty)!) {
            output.text = "Field cannot be empty."
            output.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            output.isHidden = false
            return
        }
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        let fullAdress = address.text! + " ," + city.text! + " ," + province.text! + " ," + country.text!
        
        findLocation(address: fullAdress, onSuccess: {
            (location: Location?) in
            var editUser:EditUser? = nil
            if(self.isHome) {
                editUser = EditUser(password: nil, name: nil, emailAddress: nil, phoneNumber: nil, homeLocation: location, workLocation: nil)
            } else {
                editUser = EditUser(password: nil, name: nil, emailAddress: nil, phoneNumber: nil, homeLocation: nil, workLocation: location)
            }
            RestAPIManager.sharedInstance.put_edit_user(editUser: editUser!,
                onSuccess: {(user: User) in
                    DispatchQueue.main.async{
                        UserManager.sharedInstance.setUser(user: user)
                        self.output.text = "Update Complete!"
                        self.output.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
                        self.output.isHidden = false
                        self.activityIndicator.stopAnimating()
                        self.navigationController?.popViewController(animated: true)
                    }
            }, onFailure: {_ in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.output.text = "Update Failed!"
                        self.output.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                        self.output.isHidden = false
                        return
                    }
            })
        }, onFailure: {
            print("Can't Find your location!")
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.output.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                self.output.text = "Cannot find your location: " + fullAdress
            }
            return
        }
        )
    }
    
    @IBAction func editingEnd(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.isHidden = true
    }
    
    func findLocation(address: String?, onSuccess:@escaping (Location?) -> Void, onFailure:@escaping () -> Void) {
        guard address != "" else {onSuccess(nil); return}
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    onFailure()
                    return
            }
            DispatchQueue.main.async {
                print(location.coordinate.latitude)
                print(location.coordinate.longitude)
                let returnLocation = Location(address: address!, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                onSuccess(returnLocation)
            }
        }
    }
}

extension LocationViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
