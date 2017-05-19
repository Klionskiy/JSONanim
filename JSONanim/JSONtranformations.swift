//
//  JSONtranformations.swift
//  jsonCorrectTest
//
//  Created by Gosha K on 11.05.17.
//  Copyright © 2017 Gosha K. All rights reserved.
//

import Foundation
class JSONtransformations{
    
    static let wrongJSON : [String:Any] = JSONtransformations.readJSON(fileName: "bad")!
    static let correctJSON : [String:Any] = JSONtransformations.transformWrongJSONtoCorrect(wrongJSON: JSONtransformations.wrongJSON)!
    
    static func readJSON(fileName: String) -> [String: Any]?
    {
        do
        {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json")
            {
                let data = try Data(contentsOf: file)
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any]
                {
                    return object
                }
            }
        }
        catch
        {
            return nil
        }
        return nil
        
    }
    
    static func transformWrongJSONtoCorrect(wrongJSON: [String:Any])->[String:Any]?
    {
        
        func makeGood(_ badData: Dictionary<String, Any>) -> Dictionary<String, Any>
        {
            var goodData = Dictionary<String, Any>()
            goodData["image_url"] = badData["image_url"]
            goodData["cat_id"] = (badData["query"] as! String).components(separatedBy: "|").last ?? ""
            return goodData
        }
        
        func makeGoodPair(_ badData: Dictionary<String, Any>) -> (Dictionary<String, Any>, Dictionary<String, Any>) {
            var firstGoodData = Dictionary<String, Any>()
            var secondGoodData = Dictionary<String, Any>()
            firstGoodData["image_url"] = badData["image_url_start"]
            secondGoodData["image_url"] = badData["image_url_end"]
            firstGoodData["cat_id"] = (badData["query_start"] as! String).components(separatedBy: "|").last ?? ""
            secondGoodData["cat_id"] = (badData["query_end"] as! String).components(separatedBy: "|").last ?? ""
            return (firstGoodData, secondGoodData)
        }
        
        var correctHeaders = [Dictionary<String, Any>]()
        if let wrongHeaders = wrongJSON["header"] as? [[String:Any]]
        {
            for wrongHeader in wrongHeaders {
                correctHeaders.append(makeGood(wrongHeader))
            }
        }
        let homepage = wrongJSON["homepage"] as? [Dictionary<String, Any>]
        var singlePromoWrong = [Dictionary<String, Any>]()
        var pairPromo = [Dictionary<String, Any>]()
        var contentPromo = [Dictionary<String, Any>]()
        var location = Array<[Dictionary<String, Any>]>()
        var bestsellers = [Dictionary<String, Any>]()
        
        if let homepage = homepage
        {
            for page in homepage
            {
                if let type = page["type"] as? String
                {
                    switch type
                    {
                    case "single_promo":
                        if let single = page["data"] as? Dictionary<String, Any>
                        {
                            singlePromoWrong.append(single)
                        }
                    case "pair_promo":
                        if let badPairPromo = page["data"] as? [String:Any]
                        {
                            let (first, second) = makeGoodPair(badPairPromo)
                            pairPromo.append(first)
                            pairPromo.append(second)
                        }
                    case "content_promo":
                        if let content = page["data"] as? Dictionary<String, Any>
                        {
                            contentPromo.append(content)
                        }
                    case "location":
                        if let loc = page["data"] as? [Dictionary<String, Any>]
                        {
                            location.append(loc)
                        }
                    case "bestsellers":
                        if let best = page["data"] as? [Dictionary<String, Any>]
                        {
                            for best in best
                            {
                                bestsellers.append(best)
                            }
                        }
                    default:
                        break
                    }
                }
            }
        }
        var singlePromoCorrect = [Dictionary<String, Any>]()
        for wrongSingle in singlePromoWrong
        {
            singlePromoCorrect.append(makeGood(wrongSingle))
        }
        
        return ["header" : correctHeaders,
                "pair_promo" : pairPromo,
                "single_promo" : singlePromoCorrect,
                "content_promo" : contentPromo,
                "location" : location,
                "bestsellers" : bestsellers]
    }
}
