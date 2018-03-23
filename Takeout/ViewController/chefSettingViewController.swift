//
//  chefSettingViewController.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-14.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit
import CoreLocation

class chefSettingViewController: UIViewController{
  //MARK: Properties
  @IBOutlet weak var nameTxt: UITextField!
  @IBOutlet weak var emailTxt: UITextField!
  @IBOutlet weak var PhoneTxt: UITextField!
  @IBOutlet weak var addText: UITextField!
  @IBOutlet weak var msg: UILabel!
  let activityIndicator = UIActivityIndicatorView()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        resetTextField()
        //init loading circle
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTextField()

    }
    func resetTextField() {
        let chef = ChefManager.sharedInstance.chef
        nameTxt.text = chef.name
        emailTxt.text = chef.emailAddress
        PhoneTxt.text = chef.phoneNumber
        addText.text = chef.location?.address
        msg.isHidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
  // MARK: Actions
  @IBAction func updateSettings(_ sender: UIButton) {
    activityIndicator.startAnimating()
    self.view.addSubview(activityIndicator)
    let location = Location(address:addText.text!, latitude:0, longitude:0)
    let editChef = NewChef(username:ChefManager.sharedInstance.chef.account,password:nil,name:nameTxt.text,description:nil, emailAddress:emailTxt.text, phoneNumber:PhoneTxt.text, location:location,
    storehours:nil,profilePhoto:nil,licencePhoto:nil,cuisineType:nil)
//    let editChef = NewChef(name:nameTxt.text,emailAddress:emailTxt.text, phoneNumber:PhoneTxt.text, location:Location(address:addText.text))
    RestAPIManager.sharedInstance.put_chef(editChef:editChef,
    onSuccess:{(chef:Chef) in DispatchQueue.main.async{
      self.activityIndicator.stopAnimating()
      ChefManager.sharedInstance.setChef(chef: chef)
      self.msg.text = "Update Complete!"
      self.msg.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
      self.msg.isHidden = false
      }
    }, onFailure: {_ in DispatchQueue.main.async{
        self.activityIndicator.stopAnimating()
        self.msg.text = "Update Failed!"
        self.msg.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        self.msg.isHidden = false
        return
        }
    })
  }
}
