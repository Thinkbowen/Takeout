//
//  HeroStatus.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation

struct HeroStats:Decodable {
    var localized_name: String
    var primary_attr: String
    var attack_type: String
    var legs: Int
    var img: String
}

struct HeroStats2:Decodable {
    var localized_name: String
    var primary_attr: String
    var attack_type: String
    var legs: Int
    var img: String
}

struct Text: Decodable {
    var text: String
}

struct Todo: Decodable, Encodable {
    var userId: Int
    var id: Int
    var title: String?
    var compvared: Bool
}

struct Post: Encodable, Decodable {
    var userId: Int
    var id: Int
    var title: String
    var body: String
}
