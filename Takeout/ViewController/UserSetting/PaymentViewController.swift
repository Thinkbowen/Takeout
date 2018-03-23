//
//  PaymentViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-15.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var payment: UITextField!
    let paymentOptions = ["Visa or MasterCard", "PayPal", "Maestro card"]
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        output.isHidden = true
        
        //Set payment picker
        payment.delegate = self
        let paymentPickerView = UIPickerView()
        paymentPickerView.delegate = self
        payment.inputView = paymentPickerView
        
        //Set ActivityIndicator
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true

    }
    @IBAction func updateClick(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func editingEnd(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension PaymentViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension PaymentViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return paymentOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        payment.text = paymentOptions[row]
    }
}
