//
//  ProductInfo.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 27/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProductInfo: NSObject {

    var id : String?
    var title : String?
    var image : String?
    var sale_price : String?
    var market_price : String?
    var category_id : String?
    var cartquantity : String?
    var discount : String?
    var quantity : Int?
    var dis_id : String?
    var unit : String?
    var gmqty : String?

    var quantityForCartItem : Int?

    
    init(dict : [String: Any]) {
        
        self.id = dict["id"] as? String
        self.title = dict["title"] as? String
        self.image = dict["image"] as? String

        
        let discountData = dict["discounts"] as? [[String: Any]]
        
        if let lastItem = discountData?.last {
            
            self.discount = lastItem["discount"] as? String
            self.market_price = lastItem["market_price"] as? String
            self.sale_price = lastItem["sale_price"] as? String
            self.cartquantity = lastItem["cartquantity"] as? String
            self.dis_id = lastItem["id"] as? String
            self.unit = lastItem["unit"] as? String
            self.gmqty = lastItem["gmqty"] as? String

            
            
            if ((cartquantity?.isEmpty) == nil) {
                self.quantity = Int(cartquantity ?? "0")
            }else{
                self.quantity = Int(cartquantity ?? "0")
                
            }
        }
        
    }
    
    
}
