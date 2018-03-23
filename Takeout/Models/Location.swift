//
//  Location.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation
struct Location:Encodable, Decodable {
    var address: String
    var latitude: Double
    var longitude: Double
    init(address:String, latitude:Double, longitude:Double) {
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
    }
    init() {
        self.address = ""
        self.latitude = 0
        self.longitude = 0
    }
}
