//
//  OrderManager.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-07.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class OrderManager: NSObject {
    static let sharedInstance = OrderManager()
    
    var totalPrice = Float(0)
    
    var newOrderDisplay = NewOrderDisplay()
    
    func addDish(chefDish: ChefDish) {
        if chefDish.chef._id == newOrderDisplay.chef._id {
            if newOrderDisplay.dishs.contains(where: { $0._id == chefDish.dish._id }) == false {
                newOrderDisplay.dishs.append(chefDish.dish)
                totalPrice += chefDish.dish.price
            }
        } else {
            print("Not the same chef!!")
        }
    }
    func removeDish(chefDish: ChefDish) {
        if chefDish.chef._id == newOrderDisplay.chef._id {
            if let i = newOrderDisplay.dishs.index(where: { $0._id == chefDish.dish._id }){
                newOrderDisplay.dishs.remove(at: i)
                totalPrice -= chefDish.dish.price
            }
        } else {
            print("Not the same chef!!")
        }
    }
    
    func dishStatus(chefDish: ChefDish) -> Int {
        // 0: Dish doesn't exist
        // 1: Dish exist
        // 2: Not the same chef
        if(newOrderDisplay.dishs.count == 0) {
            newOrderDisplay.chef = chefDish.chef
        }
        var status = 0
        if chefDish.chef._id == newOrderDisplay.chef._id {
            if newOrderDisplay.dishs.contains(where: { $0._id == chefDish.dish._id }){
                status = 1
            }
        } else {
            status = 2
        }
        print(chefDish.dish.name + ", " + String(status))
        return status
    }
    
    func orderNow() {
        let userID = UserManager.sharedInstance.user._id
        let userLocation = UserManager.sharedInstance.selectedLocation
        guard userLocation.address != "" && userLocation.latitude != 0 && userLocation.longitude != 0 else {
            print("Location doesn't exist!")
            return
        }
        let discountid = ""
        let note = ""
        var price = Float(0)
        var dishs = [String]()
        
        for dish in newOrderDisplay.dishs {
            dishs.append(dish._id!)
            price += dish.price
        }
        
        guard totalPrice == price else {
            print("Yo price doesn't match!!!");
            return
        }
        let newOrder = NewOrder(userid: userID, chefid: newOrderDisplay.chef._id,
                                discountid: discountid, dishs: dishs, price: price,
                                note: note, location: userLocation)
        RestAPIManager.sharedInstance.post_orders(newOrder: newOrder, onSuccess:{
            (order:Order) in
            DispatchQueue.main.async {
                print("YAYAYA ORDER POST!!!")
                print(order)
                self.newOrderDisplay.chef = Chef()
                self.newOrderDisplay.dishs.removeAll()
                self.totalPrice = Float(0)
                return
            }
        }, onFailure: {_ in
            DispatchQueue.main.async {
                print("Cannot complete order for Chef " + self.newOrderDisplay.chef.name!)
                return
            }
        })
        
    }
}
