//
//  SaveData.swift
//  JSONcorrect
//
//  Created by Gosha K on 14.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SaveDataToRealm: NSObject
{
    
    static let sharedInstance = SaveDataToRealm()
    
    let realm = try! Realm()
    let data = try! JSONSerialization.data(withJSONObject: JSONtransformations.correctJSON, options: [])
    
    func saveObjects()
    {
        try! realm.write
        {
            saveHeaders()
            saveSinglePromos()
            savePairPromos()
            saveBestsellers()
            saveContentPromo()
        }
    }
    
    // MARK - Saving data to realm
    
    func saveHeaders()
    {
        let headers = JSON(data: data)["header"]
        for (_, subJson):(String, JSON) in headers
        {
            let header = Header()
            header.image = subJson["image_url"].stringValue
            header.cat_id = subJson["cat_id"].stringValue
            realm.add(header, update: true)
        }
    }
    
    func saveSinglePromos()
    {
        let singlePromos = JSON(data: data)["single_promo"]
        for (_, subJson):(String, JSON) in singlePromos
        {
            let singlePromo = SinglePromo()
            singlePromo.image = subJson["image_url"].stringValue
            singlePromo.cat_id = subJson["cat_id"].stringValue
            realm.add(singlePromo, update: true)
        }
    }
    
    func savePairPromos()
    {
        let pairPromos = JSON(data: data)["pair_promo"]
        for (_, subJson):(String, JSON) in pairPromos
        {
            let pairPromo = PairPromo()
            pairPromo.image = subJson["image_url"].stringValue
            pairPromo.cat_id = subJson["cat_id"].stringValue
            realm.add(pairPromo, update: true)
        }
    }
    
    func saveBestsellers()
    {
        let bestsellers = JSON(data: data)["bestsellers"]
        for (_, subJson):(String, JSON) in bestsellers
        {
            let bestseller = Bestsellers()
            bestseller.product_Id = subJson["product_id"].intValue
            bestseller.save = subJson["save"].doubleValue
            bestseller.product_name = subJson["product_name"].stringValue
            bestseller.product_brand = subJson["product_brand"].stringValue
            bestseller.old_price = subJson["old_price"].doubleValue
            bestseller.promo_color = subJson["promo_color"].stringValue
            bestseller.price = subJson["price"].doubleValue
            bestseller.promo_text = subJson["promo_text"].stringValue
            bestseller.currency = subJson["currency"].stringValue
            bestseller.product_desc = subJson["product_desx"].stringValue
            realm.add(bestseller, update: true)
        }
    }
    
    func saveContentPromo()
    {
        let contentPromos = JSON(data: data)["content_promo"]
        for (_, subJson):(String, JSON) in contentPromos{
            let contentPromo = ContentPromo()
            contentPromo.image = subJson["image_url"].stringValue
            contentPromo.link = subJson["link"].stringValue
            contentPromo.promo_text = subJson["promo_text"].stringValue
            realm.add(contentPromo, update: true)
        }
    }
}
