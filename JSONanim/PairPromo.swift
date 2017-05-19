//
//  PairPromo.swift
//  JSONcorrect
//
//  Created by Gosha K on 14.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
import RealmSwift

class PairPromo: Object
{
    dynamic var image: String = ""
    dynamic var cat_id: String = ""
    
    override class func primaryKey() -> String?
    {
        return "cat_id"
    }
}
