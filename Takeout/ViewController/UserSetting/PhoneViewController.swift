//
//  PhoneViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-15.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class PhoneViewController: UIViewController {
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var output: UILabel!
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        phone.delegate = self
        phone.placeholder = UserManager.sharedInstance.user.phoneNumber
        //Set ActivityIndicator
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        output.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.output.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phone.resignFirstResponder()
    }

    @IBAction func editingEnd(_ sender: UITapGestureRecognizer) {
         self.view.endEditing(true)
    }
    
    @IBAction func updateClick(_ sender: UIButton) {
        if(phone.text?.isEmpty)! {
            output.text = "Phone number cannot be empty."
            output.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            output.isHidden = false
            return
        }
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        let editUser = EditUser(password: nil, name: nil, emailAddress:nil, phoneNumber: phone.text, homeLocation: nil, workLocation: nil)
        
        RestAPIManager.sharedInstance.put_edit_user(editUser: editUser,
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
    }
}

extension PhoneViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
