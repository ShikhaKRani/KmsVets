//
//  APIClient.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 13/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation

struct BaseUrl {
    static let BASE = "http://wisdompetclinic.xyz"
}



struct APIUrl {
    
    static let LOGIN_URL  = "\(BaseUrl.BASE)?component=json&action=login"
    static let ORDER_DETAILS  = "\(BaseUrl.BASE)?component=json&action=order_detail"

    
    
}


