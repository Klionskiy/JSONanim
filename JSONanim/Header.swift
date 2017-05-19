//
//  ImageCat.swift
//  jsonCorrectTest
//
//  Created by Gosha K on 11.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
import RealmSwift

class Header: Object
{
    dynamic var image: String = ""
    dynamic var cat_id: String = ""
    
    override class func primaryKey() -> String?
    {
        return "cat_id"
    }
}
