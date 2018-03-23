//
//  Menu.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//
import Foundation
struct Menu: Encodable, Decodable {
    var _id: String
    var name: String
    var desciription: String?
    var dishs: [Dish]?
    init(_id:String, name:String, desciription:String, dishs:[Dish]) {
        self._id = _id
        self.name = name
        self.desciription = desciription
        self.dishs = dishs
    }
}
