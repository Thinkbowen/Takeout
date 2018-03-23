//
//  chefOrderViewController.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-15.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class chefOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
  @IBOutlet weak var orderTableView: UITableView!
  var orders:[Order]?
  var order = Order()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadOrder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        private func loadOrder() {
        RestAPIManager.sharedInstance.get_chef_orders(
            onSuccess:{
                (myOrders:[Order]) in DispatchQueue.main.sync{
                print("get chef order success")
                print(myOrders)
                self.orders = myOrders
                self.orderTableView.reloadData()
                self.orderTableView.delegate = self
                self.orderTableView.dataSource = self
                }
            }, onFailure: {
                _ in DispatchQueue.main.sync{
                    print("get chef order fail")
                }
            })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return (orders?.count)!

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "chefOrderTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? chefOrderTableViewCell  else {
    fatalError("The dequeued cell is not an instance of chefOrderTableViewCell.")
        // Fetches the appropriate meal for the data source layout.
        }
        let eachOrder = orders![indexPath.row]
        
        cell.dishName.text = eachOrder.dishs![0].name
        cell.quantity.text = "1"
        cell.userName.text = eachOrder.user.name
        if(eachOrder.accepted == true){
            cell.deliverBtn.text = "delivered"
        }else{
            cell.deliverBtn.text = "waiting"
        }                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
        return cell
}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let order = orders[indexPath.row]
//        order.deliverBtn.text = "delivered"
//        //performSegue(withIdentifier: "chefEditDish", sender: self)
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? chefEditDishViewController {
//            //print(dish)
//            //let dish = self.dish
//            destination.oldDish = dish
//        }
//    }
}
