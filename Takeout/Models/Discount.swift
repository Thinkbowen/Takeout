//
//  Discount.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-04.
//  Copyright © 2018 fred. All rights reserved.
//

import Foundation
struct Discount:Decodable {
    var codestring: String
    var discountRate: Int
    var beenUsed: Bool
}

struct CodeString: Encodable {
    var codestring: String?
}
