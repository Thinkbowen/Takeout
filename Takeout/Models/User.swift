//
//  User.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation
struct User: Decodable {
    var _id: String
    var updatedAt: String?
    var createdAt: String?
    var account: String
    var name: String
    var emailAddress: String
    var phoneNumber: String
    var homeLocation: Location?
    var workLocation: Location?
    var points: Double?
    
    init() {
        self._id = ""
        self.updatedAt = ""
        self.createdAt = ""
        self.account = ""
        self.name = ""
        self.emailAddress = ""
        self.phoneNumber = ""
        self.homeLocation = nil
        self.workLocation = nil
        self.points = 0
    }
    
    init(_id:String, updatedAt:String, createdAt:String,
         account:String, name:String, emailAddress:String,
         phoneNumber:String, homeLocation:Location,
         workLocation:Location, points:Double) {
        self._id = _id
        self.updatedAt = updatedAt
        self.createdAt = createdAt
        self.account = account
        self.name = name
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.homeLocation = homeLocation
        self.workLocation = workLocation
        self.points = points
    }
}

struct EditUser: Encodable {
    var password: String?
    var name: String?
    var emailAddress: String?
    var phoneNumber: String?
    var homeLocation: Location?
    var workLocation: Location?
    init(password:String?, name:String?, emailAddress:String?,
         phoneNumber:String?, homeLocation:Location?, workLocation:Location?) {
        if((password) != nil)       {self.password = password}
        if((name) != nil)           {self.name = name}
        if((emailAddress) != nil)   {self.emailAddress = emailAddress}
        if((phoneNumber) != nil)    {self.phoneNumber = phoneNumber}
        if((homeLocation) != nil)   {self.homeLocation = homeLocation}
        if((workLocation) != nil)   {self.workLocation = workLocation}
    }
}
