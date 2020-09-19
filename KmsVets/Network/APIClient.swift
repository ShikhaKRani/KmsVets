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

struct AppURL {
    static let SLIDER_URL = "\(BaseUrl.BASE)/userfiles/contents/big/"

}



struct APIUrl {
    
    static let LOGIN_URL  = "\(BaseUrl.BASE)?component=json&action=login"
    static let ORDER_DETAILS  = "\(BaseUrl.BASE)?component=json&action=order_detail"
    static let GET_SLIDER_IMAGE  = "\(BaseUrl.BASE)?component=json&action=get_slider_image"
    static let GET_PET_LIST  = "\(BaseUrl.BASE)/visitapi/index.php/getpet_list"


    
}

//http://wisdompetclinic.xyz/visitapi/index.php/getpet_list

