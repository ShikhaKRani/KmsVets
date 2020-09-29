//
//  CartModel.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 28/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CartModel: NSObject {

    var id : String?
    var title : String?
    var slug : String?
    var item_description : String?
    var image : String?
    var cod : String?
    var emi : String?
    var status : String?
    var deliverycharge : String?
    var tax : String?
    var category_id : String?
    var on_date : String?
    var dis_id : String?
    var sale_price : String?
    var market_price : String?
    var gmqty : String?
    var unit : String?
    var discount : String?
    var currency : String?
    var cartquantity : String?
    
    var quantityForCartItem : Int?
    var quantity : Int?

    var isDELETE : Bool?

    
    
    init(dict : [String: Any] ) {
        
        self.id = dict["id"] as? String
        self.title = dict["title"] as? String
        self.slug = dict["slug"] as? String
        self.item_description = dict["description"] as? String
        self.image = dict["image"] as? String
        self.cod = dict["cod"] as? String
        self.emi = dict["emi"] as? String
        self.status = dict["status"] as? String
        self.deliverycharge = dict["deliverycharge"] as? String
        self.tax = dict["tax"] as? String
        self.category_id = dict["category_id"] as? String
        self.on_date = dict["on_date"] as? String
        self.dis_id = dict["dis_id"] as? String
        self.sale_price = dict["sale_price"] as? String
        self.market_price = dict["market_price"] as? String
        self.gmqty = dict["gmqty"] as? String
        self.discount = dict["discount"] as? String
        self.currency = dict["currency"] as? String
        self.cartquantity = dict["cartquantity"] as? String

        self.unit = dict["unit"] as? String

        
        if ((cartquantity?.isEmpty) == nil) {
            self.quantity = Int(cartquantity ?? "0")
        }else{
            self.quantity = Int(cartquantity ?? "0")
            
        }
        
        
    }
    
    
}
