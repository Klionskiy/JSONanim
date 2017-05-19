//
//  BestSellers.swift
//  jsonCorrectTest
//
//  Created by Gosha K on 12.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
import RealmSwift

class Bestsellers: Object
{
    dynamic var product_Id: Int = 0
    dynamic var save: Double = 0.0
    dynamic var product_name: String = ""
    dynamic var product_brand: String = ""
    dynamic var old_price: Double = 0.0
    dynamic var promo_color: String = ""
    dynamic var price: Double = 0.0
    dynamic var promo_text: String = ""
    dynamic var currency: String = ""
    dynamic var product_desc: String = ""
    
    override class func primaryKey() -> String?
    {
        return "product_Id"
    }
}
