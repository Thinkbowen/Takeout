//
//  chiefLoginViewController.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-10.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class chefLoginViewController: UIViewController {
  //MARK: Properties
  @IBOutlet weak var chefName: UITextField!
  @IBOutlet weak var chefPass: UITextField!
  @IBOutlet weak var chefSigninBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  //MARK: Actions
  @IBAction func chefSignin(_ sender: UIButton) {
    //Activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        //api call
RestAPIManager.sharedInstance.post_chef_login(login:Login(username:chefName.text!,password:chefPass.text!)
      , onSuccess: {(chef: Chef) in
        DispatchQueue.main.async{
          activityIndicator.stopAnimating()
          ChefManager.sharedInstance.setChef(chef: chef)
          print("chef loged in")
          self.performSegue(withIdentifier: "chefView", sender: self)
        }
    }
      , onFailure: {_ in DispatchQueue.main.async {
        print("post_chef_login failed")
        return
        }
    })
  }

}
