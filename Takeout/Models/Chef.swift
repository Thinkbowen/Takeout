//
//  Chef.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation

struct Rating:Encodable, Decodable{
    var stars: Int
    var votes: Int
    init() {
        self.stars = 0
        self.votes = 0
    }
}

struct EditRating: Encodable{
    var rate: Int?
}
struct Storehours:Encodable, Decodable{
    var open: Int
    var close: Int
    var saturday: Bool
    var sunday: Bool
    init() {
        self.open = 0
        self.close = 0
        self.saturday = true
        self.sunday = true
    }
}
struct Chef: Decodable {
    var _id: String
    var updatedAt: String?
    var createdAt: String?
    var account: String
    var name: String!
    var description: String?
    var emailAddress: String
    var phoneNumber: String
    var rating: Rating
    var location: Location?
    var storehours: Storehours?
    var profilePhoto: String?
    var licencePhoto: String?
    var cuisineType: String
    var menus: [String]?
    var paymentRatio: Float!
    var distance: Double!
    
    init(_id:String, account:String, name:String, description:String, emailAddress:String, phoneNumber:String, rating:Rating, location:Location, storehours: Storehours, profilePhoto:String, licencePhoto:String, cuisineType:String, menus:[String], paymentRatio:Float, distance: Double) {
        self._id = _id
        self.account = account
        self.name = name
        self.description = description
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.rating = rating
        self.location = location
        self.storehours = storehours
        self.profilePhoto = profilePhoto
        self.cuisineType = cuisineType
        self.menus = menus
        self.paymentRatio = paymentRatio
        self.distance = distance
    }
    
    init() {
        self._id = ""
        self.account = ""
        self.name = ""
        self.description = ""
        self.emailAddress = ""
        self.phoneNumber = ""
        self.rating = Rating()
        self.location = Location()
        self.storehours = Storehours()
        self.profilePhoto = ""
        self.licencePhoto = ""
        self.cuisineType = ""
        self.paymentRatio = 0
        self.distance = 0
    }
}
struct NewChef: Encodable, Decodable{
    var username: String?
    var password: String?
    var name: String?
    var description: String?
    var emailAddress: String?
    var phoneNumber: String?
    var location: Location?
    var storehours: Storehours?
    var profilePhoto: String?
    var licencePhoto: String?
    var cuisineType: String?
    
    init(username:String?, password:String?, name:String?, description:String?, emailAddress:String?, phoneNumber:String?, location:Location?, storehours:Storehours?, profilePhoto:String?, licencePhoto:String?,cuisineType:String?) {
        self.username = username
        self.password = password
        self.name = name
        self.description = description
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.location = location
        self.storehours = storehours
        self.profilePhoto = profilePhoto
        self.licencePhoto = licencePhoto
        self.cuisineType = cuisineType
    }
}
