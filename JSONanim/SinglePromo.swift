//
//  SinglePromo.swift
//  jsonCorrectTest
//
//  Created by Gosha K on 12.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
import RealmSwift

class SinglePromo: Object
{
    dynamic var image: String = ""
    dynamic var cat_id: String = ""
    
    override class func primaryKey() -> String?
    {
        return "cat_id"
    }
}
