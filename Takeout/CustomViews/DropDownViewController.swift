//
//  DropDownViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-13.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class DropDownViewController: UIViewController {
    @IBOutlet var dropDownView: UIView!
    @IBOutlet weak var homeLocation: UIButton!
    @IBOutlet weak var workLocation: UIButton!
    @IBOutlet weak var searchLocation: UIButton!
    var locationSection = [UIButton]()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSection.append(homeLocation)
        locationSection.append(workLocation)
        locationSection.append(searchLocation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func selectLocationBtnClick(_ sender: UIButton) {
        for location in locationSection {
            UIView.animate(withDuration: 0.3, animations: {
                location.isHidden = !location.isHidden
                self.view.layoutIfNeeded()
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
