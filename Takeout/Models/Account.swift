//
//  account.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation

struct Account:Decodable {
    var username: String?
    var password: String?
    var activated: Bool?
}

struct Register:Encodable, Decodable {
    var username: String
    var password: String
    var name: String
    var emailAddress: String
    var phoneNumber: String
    
    init(username:String, password:String, name:String, emailAddress:String, phoneNumber:String) {
        self.username = username
        self.password = password
        self.name = name
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
    }
}

struct Login: Encodable, Decodable {
    var username: String
    var password: String
    init(username:String, password:String) {
        self.username = username
        self.password = password
    }
}

struct Activated: Encodable {
    var activated: Bool
}
