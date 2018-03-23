//
//  DishViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-06.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class DishViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dishImg: UIImageView!
    
    @IBOutlet weak var dishName: UILabel!
    
    @IBOutlet weak var dishDescipition: UILabel!
    
    @IBOutlet weak var dishPrice: UILabel!
    
    @IBOutlet weak var dishAddToCart: UIButton!
    
    //var dish: Dish?
    var chefDish: ChefDish?
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        let dishStatus = OrderManager.sharedInstance.dishStatus(chefDish: chefDish!)
        if (dishStatus == 0) {
            OrderManager.sharedInstance.addDish(chefDish: chefDish!)
            dishAddToCart.setTitle("ALREADY IN CART", for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       // scrollView.contentSize.height = 2000;
        guard chefDish?.dish.price != nil else {
            return
        }
        dishName.text = chefDish?.dish.name
        if(chefDish?.dish.description?.isEmpty == false) {
            dishDescipition.text = (chefDish?.dish.description)!
        } else {
             dishDescipition.text = "No description for this dish."
        }
       
        dishPrice.text = "\((chefDish?.dish.price)!)"
        if(OrderManager.sharedInstance.dishStatus(chefDish: chefDish!) == 1) {
            dishAddToCart.setTitle("ALREADY IN CART", for: .normal)
        } else if (OrderManager.sharedInstance.dishStatus(chefDish: chefDish!) == 2) {
            dishAddToCart.setTitle("OTHER ORDER IN CART", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dishStatus = OrderManager.sharedInstance.dishStatus(chefDish: chefDish!)
        if(dishStatus == 0) {
            dishAddToCart.setTitle("ADD TO CART", for: .normal)
        } else if (dishStatus == 1){
            dishAddToCart.setTitle("ALREADY IN CART", for: .normal)
        } else {
             dishAddToCart.setTitle("OTHER ORDER IN CART", for: .normal)
        }
    }

}
