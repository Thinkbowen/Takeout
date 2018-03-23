//
//  OrderViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-07.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

extension OrderViewController: OrderCellDelegate {
    func removeDishClick(chefDish: ChefDish) {
        OrderManager.sharedInstance.removeDish(chefDish: chefDish)
        self.orderTableView.reloadData()
    }
}

class OrderViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var locationInput: UITextField!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var orderTableView: UITableView!
    let locationOptions = ["Home Location", "Work Location"]
    var dishs = [Dish]()
    var newOrders = [NewOrder]()
    
    func resetLocation() {
        if (UserManager.sharedInstance.selectedLocation.address != "") {
            locationInput.text = UserManager.sharedInstance.selectedLocation.address
        } else {
            locationInput.text = "Please Select Your Location"
        }
    }
    @IBAction func endEditing(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func EmptyCart() {
        let messageLabel = UILabel(frame:CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height:  self.view.bounds.size.height))
        messageLabel.text = "Your Cart Is Empty"
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        self.orderTableView.backgroundView = messageLabel
        self.orderTableView.backgroundView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.orderTableView.separatorStyle = .none;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(OrderManager.sharedInstance.newOrderDisplay.dishs.count == 0) {
            EmptyCart()
            return 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderManager.sharedInstance.newOrderDisplay.dishs.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dishCount = OrderManager.sharedInstance.newOrderDisplay.dishs.count
        print(dishCount)
        if (indexPath.row == dishCount) {
            let cell = Bundle.main.loadNibNamed("OrderPaymentInfoTableViewCell", owner: self, options: nil)?.first as! OrderPaymentInfoTableViewCell
            let totalPrice = OrderManager.sharedInstance.totalPrice
            let tax = totalPrice * 0.15
            let grandTotal = totalPrice + tax
            cell.total.text = "\((totalPrice))"
            cell.tax.text = "\((tax))"
            cell.grandTotal.text = "\((grandTotal))"
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell") as! OrderTableViewCell
            let dish =  OrderManager.sharedInstance.newOrderDisplay.dishs[indexPath.row]
            let chef = OrderManager.sharedInstance.newOrderDisplay.chef
            cell.dish = dish
            cell.chefDish = ChefDish(chef: chef, dish: dish)
            cell.delegate = self
            // Of course, need to change this later....
            cell.dishName.text = dish.name
            // cell.dishImg = UIImage(dish.photo)
            cell.dishDescription.text = dish.description
            cell.dishPrice.text = "\((dish.price))"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == OrderManager.sharedInstance.newOrderDisplay.dishs.count) {
            return CGFloat(280)
        } else {
            return CGFloat(217)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView =  Bundle.main.loadNibNamed("OrderChefInfoTableViewCell", owner: self, options: nil)?.first as! OrderChefInfoTableViewCell
        let chef = OrderManager.sharedInstance.newOrderDisplay.chef
        headerView.chef = chef
        headerView.chefLocation.text = chef.location?.address
        headerView.chefName.text = chef.name
        headerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        headerView.initLocation()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(280)
    }
    
//    @IBAction func orderNowBtnClick(_ sender: UIButton) {
//      print("order btn clicked")
//        OrderManager.sharedInstance.orderNow()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        
        locationInput.delegate = self
        let locationPickerView = UIPickerView()
        locationPickerView.delegate = self
        locationInput.inputView = locationPickerView
        
        resetLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetLocation()
        orderTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension OrderViewController:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension OrderViewController:UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let option = locationOptions[row]
        if option == "Home Location" {
            let homeLocation = UserManager.sharedInstance.user.homeLocation
            guard homeLocation != nil else {
                locationInput.text = "Please add home address in setting"
                view.endEditing(true)
                return
            }
            locationInput.text = (homeLocation?.address)!
            UserManager.sharedInstance.selectHomeLocation()
        }
        else if option == "Work Location" {
            let workLocation = UserManager.sharedInstance.user.workLocation
            guard workLocation != nil else {
                locationInput.text = "Please add work address in setting"
                view.endEditing(true)
                return
            }
            locationInput.text = (workLocation?.address)!
            UserManager.sharedInstance.selectWorkLocation()
        }
        view.endEditing(true)
    }
}
