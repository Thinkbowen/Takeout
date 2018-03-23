//
//  EmailViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-15.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var outputMsg: UILabel!
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.delegate = self
        emailInput.placeholder = UserManager.sharedInstance.user.emailAddress
        //Set ActivityIndicator
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        outputMsg.isHidden = true
    }
    
    @IBAction func updateClick(_ sender: UIButton) {
        if(emailInput.text?.isEmpty)! {
            outputMsg.text = "Email cannot be empty."
            outputMsg.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            outputMsg.isHidden = false
            return
        }
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        let editUser = EditUser(password: nil, name: nil, emailAddress: self.emailInput.text, phoneNumber: nil, homeLocation: nil, workLocation: nil)
        
        RestAPIManager.sharedInstance.put_edit_user(editUser: editUser,
            onSuccess: {(user: User) in
                DispatchQueue.main.async{
                    UserManager.sharedInstance.setUser(user: user)
                    self.outputMsg.text = "Update Complete!"
                    self.outputMsg.textColor = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
                    self.outputMsg.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                }
            }, onFailure: {_ in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.outputMsg.text = "Update Failed!"
                    self.outputMsg.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                    self.outputMsg.isHidden = false
                    return
                }
            })
    }
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.outputMsg.isHidden = true
    }
}


extension EmailViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
