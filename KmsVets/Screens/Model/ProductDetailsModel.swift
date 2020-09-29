//
//  ProductDetailsModel.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 29/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProductDetailsModel: NSObject {

    
    var count : Int?
    var cartquantity : Int?

    var id : String?
    var title : String?
    var slug : String?
    var descriptionPr : String?
    var image : String?
    var cod : String?
    var emi : String?
    var status : String?
    var deliverycharge : String?
    var tax : String?
    var category_id : String?
    var on_date : String?

    
    
    init( dict : [String: Any]) {
        
        self.count  = dict["count"] as? Int ?? 0
        self.cartquantity  = dict["cartquantity"] as? Int ?? 0
        
        let data = dict["data"] as? [[String: Any]]
        if let lastDict = data?.last {
            self.id  = lastDict["id"] as? String ?? ""
            self.title  = lastDict["title"] as? String ?? ""
            self.slug  = lastDict["slug"] as? String ?? ""
            self.descriptionPr  = lastDict["description"] as? String ?? ""
            self.image  = lastDict["image"] as? String ?? ""
            self.cod  = lastDict["cod"] as? String ?? ""
            self.status  = lastDict["status"] as? String ?? ""
            self.deliverycharge  = lastDict["deliverycharge"] as? String ?? ""
            self.tax  = lastDict["tax"] as? String ?? ""
            self.category_id  = lastDict["category_id"] as? String ?? ""
            self.on_date  = lastDict["on_date"] as? String ?? ""

        }

        
        
    }
    
    
    
    
    
    /*
     
     {
         "count": 1,
         "data": [
             {
                 "id": "267",
                 "title": "Johnson Baby Milk Lotion",
                 "slug": "Johnson Baby Milk Lotion",
                 "description": "\\\\\\\\r\\\\\\\\nEnriched with natural milk extracts and Vitamin E\\\\\\\\r\\\\\\\\nContains rich emollients and added moisturizers\\\\\\\\r\\\\\\\\nHelps to give skin an immediate moisture boost\\\\\\\\r\\\\\\\\n100% clinically proven mild and gentle\\\\\\\\r\\\\\\\\nAllergy tested; Dermatologist tested\\\\\\\\r\\\\\\\\nEvery Johnson&rsquo;s product passes a 5 level safety assurance process\\\\\\\\r\\\\\\\\n",
                 "image": "1529048635.jpg",
                 "cod": "0",
                 "emi": "0",
                 "status": "1",
                 "deliverycharge": "",
                 "tax": "",
                 "category_id": "26",
                 "on_date": "2018-12-28 03:53:01"
             }
         ],
         "cartquantity": 0
     }
     
     **/
    
}
