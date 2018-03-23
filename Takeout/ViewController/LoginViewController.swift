//
//  loginViewController.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-10.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
    @IBAction func signin(_ sender: AnyObject) {
        //Activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
             //RestAPIManager.sharedInstance.post_user_login(userName: username.text!, passWord: password.text!
        RestAPIManager.sharedInstance.post_user_login(userName: "test1", passWord: "123"
            , onSuccess: {(user: User) in
                DispatchQueue.main.async{
                    activityIndicator.stopAnimating()
                    UserManager.sharedInstance.setUser(user: user)
                    print("loged in")
                    self.performSegue(withIdentifier: "userView", sender: self)
                }
        }
            , onFailure: {_ in DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                print("post_user_login failed")
                return
                }
        })
    }
    
}
