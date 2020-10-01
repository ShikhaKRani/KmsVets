//
//  PlaceOrderViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 28/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Alamofire

class PlaceOrderViewController: BaseViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var totalAmountLbl: UILabel!
    
    var totalAmount : Int?
    var cartItemsArray : [CartModel]?
    var fullnameStr = ""
    var email = ""
    var mobile = ""
    var address = ""
    var zipcode = ""
    var landmark = ""
    var userName = ""
    var city = ""
    var userID = ""
    var COD = "0"
    var order_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Place Order"
        fullnameStr = UserDefaults.standard.string(forKey: "name") ?? ""
        userName = UserDefaults.standard.string(forKey: "username") ?? ""
        email = UserDefaults.standard.string(forKey: "email") ?? ""
        mobile = UserDefaults.standard.string(forKey: "mobile") ?? ""
        address = UserDefaults.standard.string(forKey: "address") ?? ""
        zipcode = UserDefaults.standard.string(forKey: "zipcode") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        userID = UserDefaults.standard.string(forKey: "id") ?? ""
        self.continueBtn.addTarget(self, action: #selector(updateBtnAtion), for: .touchUpInside)
        self.totalAmountLbl.text = "\(StringConstant.RuppeeSymbol)\(totalAmount ?? 0)"
        
    }
    
    
    @objc func updateBtnAtion() {
       

        let todayDate = Date().string(format: "yyyy-MM-dd")
        
        let itemModelArray : [CartModel] = self.cartItemsArray ?? []
        var params: [String: Any] = [
            "person_name" : fullnameStr,
            "email" : "\(email)",
            "mobile" : "\(mobile)",
            "address" : "\(address)",
            "zipcode" : "\(zipcode)",
            "city" : "\(city)",
            "totalitem":"\(itemModelArray.count )",
            "totalprice": "\(totalAmount ?? 0)",
            "user_id" : "\(userID)",
            "cod" : "\(COD)",
            "delivery_time": "Morning",
            "order_date":"\(todayDate)",
            "promoPrice":"0",
            "delivery_date": "\(todayDate)",
            "delivery_charge": "25",
            "delivery_instant" : "0",
            "apply_coupon" : "0",
            ]
     
        for index in (0..<itemModelArray.count) {
            let model = itemModelArray[index]
            params["order_item[\(index)]"] = "\(model.id ?? "")"//PRODUCT ID
            params["order_item_type[\(index)]"] = "\(model.unit ?? "")" //KG
            params["order_item_gmqty[\(index)]"] = "\(model.gmqty ?? "")"
            params["order_item_qty[\(index)]"] = "\(model.cartquantity ?? "")"
            params["order_item_price[\(index)]"] = "\(model.sale_price ?? "")"
            params["order_discount_id[\(index)]"] = "\(model.dis_id ?? "")"

        }
        
        bookItem(json: params)
    }
    
    func bookItem(json:[String : Any]) {
        self.showHud("Booking Order")
        AF.request(APIUrl.BOOK_ORDER, method: .post, parameters: json, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                self.hideHUD()

                if let responseDict = value as? NSDictionary {
                    print(responseDict)
                    UserDefaults.standard.set(responseDict["order_id"], forKey: "payment_order_id")
                    
                    self.order_id = UserDefaults.standard.string(forKey: "payment_order_id") ?? ""
                    DispatchQueue.main.async { () -> Void in
                        self.redirectToPaymentScreen()
                    }
                    
                
                }
                
                
                
            case .failure(let error):
                print(error)
                self.hideHUD()
            }
        }
    }
    
    
    func redirectToPaymentScreen() {
        
        let storyBoard = UIStoryboard.init(name: "Payment", bundle: nil)
        if let paymentVC = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
            self.order_id = UserDefaults.standard.string(forKey: "payment_order_id") ?? ""

            paymentVC.firstName = fullnameStr
            paymentVC.email = email
            paymentVC.order_id = self.order_id
            paymentVC.totalPriceAmount = "\(totalAmount ?? 0)"
            
            paymentVC.screen = "cart"
            self.navigationController?.pushViewController(paymentVC, animated: true)
        }
        
        
    }
    
    
}




