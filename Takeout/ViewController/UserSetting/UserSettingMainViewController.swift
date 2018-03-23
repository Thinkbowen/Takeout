//
//  UserSettingMainViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-15.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class UserSettingMainViewController: UIViewController {
    @IBOutlet weak var email: UIButton!
    @IBOutlet weak var phone: UIButton!
    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var work: UIButton!
    @IBOutlet weak var payment: UIButton!
    @IBOutlet weak var points: UILabel!
    var locationUpdate = false
    var isHome = false
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTextField()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationUpdate = false
        resetTextField()
    }
    @IBAction func selectHome(_ sender: UIButton) {
        isHome = true
        locationUpdate = true
        performSegue(withIdentifier: "showLocation", sender: self)
    }
    @IBAction func selectWork(_ sender: UIButton) {
        isHome = false
        locationUpdate = true
        performSegue(withIdentifier: "showLocation", sender: self)
    }
    func resetTextField() {
        let user = UserManager.sharedInstance.user
        email.setTitle("Email: " +  user.emailAddress,for: .normal)
        phone.setTitle("Phone: " +  user.phoneNumber,for: .normal)
        home.setTitle("Home: " +  (user.homeLocation?.address)!,for: .normal)
        work.setTitle("Work: " +  (user.workLocation?.address)!,for: .normal)
        points.text = "\((user.points)!)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //retrieve the destination view controller for free
        if(locationUpdate) {
            if let myDestincationViewController = (segue.destination as? LocationViewController) {
                print(self.isHome)
                myDestincationViewController.isHome = self.isHome
            }
        }
        
    }

}
