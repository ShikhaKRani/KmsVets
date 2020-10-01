//
//  ServiceOrderModel.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 01/10/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ServiceOrderModel: NSObject {
    
    var service_id : String? //id
    var service_cat : String?
    var name : String?
    var mobile : String?
    var address : String?
    var email : String?
    var petname : String?
    var pet_bride : String?
    var pet_age : String?
    var pet_id : String?
    var pet_category : String?
    var pincode : String?
    var bookdate : String?
    var service : String?
    var time : String?
    var visit_charge : String?
    var delivery_charge : String?
    var total_charge: String?
    var user_id : String?
    var pettype : String?
    
    
    init(dict : [String : Any]) {
        self.service_id = dict["id"] as? String
        self.service_cat = dict["service_cat"] as? String
        self.name = dict["name"] as? String
        self.mobile = dict["mobile"] as? String
        self.address = dict["address"] as? String
        self.email = dict["email"] as? String
        self.petname = dict["petname"] as? String
        self.pet_bride = dict["pet_bride"] as? String
        self.pet_age = dict["pet_age"] as? String
        self.pet_id = dict["pet_id"] as? String
        self.pet_category = dict["pet_category"] as? String
        self.pincode = dict["pincode"] as? String
        self.bookdate = dict["bookdate"] as? String
        self.service = dict["service"] as? String
        self.time = dict["time"] as? String
        self.visit_charge = dict["visit_charge"] as? String
        self.delivery_charge = dict["delivery_charge"] as? String
        self.total_charge = dict["total_charge"] as? String
        self.user_id = dict["user_id"] as? String
        self.pettype = dict["pettype"] as? String
        
    }
}
