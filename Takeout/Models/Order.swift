//
//  Order.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation

struct CreditCard:Encodable{
    var amount: Double
    var payment_method: String
    /*var card: {
        var name: String
        var number: String
        var expiry_month: String
        var expiry_uear: String
        var cvd: String
    }*/
}

struct paymentFeedback:Decodable{
    var id: String
    var authorizing_merchant_id: Int
    var approved: String
    var message_id: String
    var message: String
    var auth_code: String
    var created: String
    var order_number: String
    var type: String
    var payment_method: String
    var risk_score: Int
}

struct Order:Decodable {
    var user: User
    var chef: Chef
    var dishs: [Dish]?
    var discount: String?
    var note: String?
    var price: Float
    var status: String
    var accepted: Bool
    var deliveryLocation: Location?

    init(){
        self.user = User()
        self.chef = Chef()
        self.dishs = [Dish]()
        self.discount = ""
        self.note = ""
        self.price = 0.0
        self.status = ""
        self.accepted = false
        self.deliveryLocation = nil
    }
}

struct NewOrder: Encodable, Decodable {
    var userid: String
    var chefid: String
    var discountid: String
    var dishs: [String]
    var price: Float
    var note: String
    var location: Location
    
    init(userid: String, chefid:String, discountid: String?, dishs:[String], price:Float, note:String, location:Location) {
        self.userid = userid
        self.chefid = chefid
        self.discountid = discountid!
        self.dishs = dishs
        self.price = price
        self.note = note
        self.location = location
    }
}

struct NewOrderDisplay {
    var chef: Chef
    var dishs: [Dish]
    
    init(chef: Chef, dishs: [Dish]) {
        self.chef = chef
        self.dishs = dishs
    }
    init() {
        self.chef = Chef()
        self.dishs = [Dish]()
    }
}

struct EditOrderStatus: Encodable {
    var accepted: Bool
    var status: String
}


