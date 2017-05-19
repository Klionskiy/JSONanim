//
//  AllStoredData.swift
//  JSONcorrect
//
//  Created by Gosha K on 14.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
import RealmSwift

class AllStoredData
{

    public var headers = [Header]()
    public var singlePromo = [SinglePromo]()
    public var bestselleres = [Bestsellers]()
    public var contentPromo = [ContentPromo]()
    public var pairPromo = [PairPromo]()
    public var pairPromos = [(PairPromo, PairPromo)]()

    let realm = try! Realm()

    public init()
    {
        self.headers = realm.objects(Header.self).sorted(byKeyPath: "cat_id").toArray()
        self.singlePromo = realm.objects(SinglePromo.self).sorted(byKeyPath: "cat_id").toArray()
        self.bestselleres = realm.objects(Bestsellers.self).sorted(byKeyPath: "product_Id").toArray()
        self.pairPromo = realm.objects(PairPromo.self).toArray()
        self.contentPromo = realm.objects(ContentPromo.self).sorted(byKeyPath: "link").toArray()
        
        var pair = [(PairPromo, PairPromo)]()
        for i in 0...pairPromo.count
        {
            if i%2 == 0 && i != pairPromo.count
            {
                pair.append((pairPromo[i], pairPromo[i+1]))
            }
        }
        self.pairPromos = pair
    }
}

extension Results
{
    func toArray() -> [T]
    {
        return self.map{$0}
    }
}

extension RealmSwift.List
{
    
    func toArray() -> [T]
    {
        return self.map{$0}
    }
}
