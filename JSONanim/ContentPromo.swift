//
//  ContentPromo.swift
//  JSONcorrect
//
//  Created by Gosha K on 14.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
import RealmSwift

class ContentPromo: Object
{
    dynamic var image: String = ""
    dynamic var link: String = ""
    dynamic var promo_text: String = ""

    
    override class func primaryKey() -> String?
    {
        return "link"
    }
}
