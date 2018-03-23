//
//  LocationPickerViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-13.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class LocationPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let locationSelection = ["Home Location", "Work Location", "Search Location"]
    enum location: String {
        case home = "Home Location"
        case work = "Work Location"
        case search = "Search Location"
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationSelection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationSelection[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let option = locationSelection[row]
        if option == "Home Location" {
            UserManager.sharedInstance.selectHomeLocation()
        } else if option == "Work Location" {
             UserManager.sharedInstance.selectWorkLocation()
        } else {
            //
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
