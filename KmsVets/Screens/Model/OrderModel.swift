//
//  OrderModel.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 29/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class OrderModel: NSObject {

    var order_id : String?
    var total_price : String?
    var title : String?
    var image : String?
    var currency : String?
    var order_date : String?
    var cod : Bool?
    var payment_status : Bool?
    var discount : String?
    var order_status : String?
    var delivery_date : String?
    var delivery_instant : String?
    var delivery_charge : String?
    var delivery_time : String?
    var recipt_no : String?

    
    
    
    init(dict : [String : Any]) {
        
        self.order_id = dict["order_id"] as? String
        self.total_price = dict["total_price"] as? String
        self.title = dict["title"] as? String
        self.image = dict["image"] as? String
        self.currency = dict["currency"] as? String
        self.order_date = dict["order_date"] as? String
        self.cod = dict["cod"] as? Bool
        self.order_status = dict["order_status"] as? String
        self.payment_status = dict["payment_status"] as? Bool
        self.discount = dict["discount"] as? String
        self.delivery_date = dict["delivery_date"] as? String
        self.delivery_instant = dict["delivery_instant"] as? String
        self.delivery_charge = dict["delivery_charge"] as? String
        self.delivery_time = dict["delivery_time"] as? String
        self.recipt_no = dict["recipt_no"] as? String

    }
}
