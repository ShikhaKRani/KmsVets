//
//  Constant.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 14/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import UIKit


//MARK:- App Constant
struct AppConstant {
    //constant
    static let UserKey  = "5642vcb546gfnbvb7r6ewc211365vhh34"
}

//MARK:- String Constant
struct StringConstant {
    
    //Identifier
    static let  CustomerInformationCell = "CustomerInformationCell"
    static let  ProfileViewTableViewCell = "ProfileViewTableViewCell"
    static let  BookingNewPuppyTableViewCell = "BookingNewPuppyTableViewCell"
    static let  NewPuppyHistoryTableViewCell = "NewPuppyHistoryTableViewCell"
    static let  BookinfForSurgeryTableViewCell = "BookinfForSurgeryTableViewCell"
    static let  BookingSurgeryHistoryTableViewCell = "BookingSurgeryHistoryTableViewCell"
    //title
    static let  Apptitle = "KMS Vets"
    
    
}

//MARK:- Color Constant
struct ColorConstant {
    
    static let themeColor = UIColor(red: 01/255, green: 61/255, blue: 55/255, alpha: 1)
    static let navThemeColor = UIColor(red: 01/255, green: 52/255, blue: 48/255, alpha: 1)
    
}


extension NSAttributedString
{
    convenience init(text: String, aligment: NSTextAlignment, color:UIColor) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor:color])
    }
}

