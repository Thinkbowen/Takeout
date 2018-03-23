//
//  Dish.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation
struct Dish:Encodable, Decodable {
    var _id: String?
    var name: String
    var description: String?
    var price: Float
    var photo: String
    var cuisineType: String
    var cooktime: Int?
    
    init(_id:String?, name:String, description:String?, price:Float, photo:String, cuisineType:String, cooktime:Int?) {
      self._id = _id
        self.name = name
      self.description = description
        self.price = price
        self.photo = photo
        self.cuisineType = cuisineType
        self.cooktime = cooktime
    }
    
    init() {
        self._id = ""
        self.name = ""
        self.description = ""
        self.price = 0
        self.photo = ""
        self.cuisineType = ""
        self.cooktime = 0
    }
}

struct ChefDish {
    var chef: Chef
    var dish: Dish
    init(chef: Chef, dish:Dish) {
        self.chef = chef
        self.dish = dish
    }
}
