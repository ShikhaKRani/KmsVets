//
//  TransactionSuccessViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 26/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Alamofire

class TransactionSuccessCell : UITableViewCell {
    @IBOutlet weak var msgLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var goToHome: UIButton!
    @IBOutlet weak var trackOrderBtn: UIButton!
    @IBOutlet weak var continueShoppingBtn: UIButton!
    @IBOutlet weak var updateProfileBtn: UIButton!
}



class TransactionSuccessViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var screen : String?
    var order_id : String?
    var totalPriceAmount : String?
    var msg : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---->>>>>>>>>>> screen : \(screen ?? "") order_id = \(order_id ?? "0")")
        self.checkPaymentStatus()
    }
    
    //api call
    
    func checkPaymentStatus() {
        
        self.showHud("Updating Order")
        let params = ["order_id":"\(order_id ?? "")"] as Dictionary<String, String>
        AF.request(APIUrl.PAYMENT_STATUS, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                self.hideHUD()
                if let responseDict = value as? NSDictionary {
                    print(responseDict)
                    if self.screen == "cart" {
                        
                        let status = responseDict["status"] as? String
                        if status == "sucess" {
                            self.msg = "Your Order has been placed successfully."
                        }else{
                            self.msg =  "Payment Status Failed !!"
                            
                        }
                        self.clearCart()
                    }else{
                        let status = responseDict["status"] as? String
                        if status == "sucess" {
                            self.msg = "Your Order has been placed successfully."
                                
                        }else{
                            self.msg =  "Payment Status Failed !!"
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
                self.hideHUD()
                self.msg =  "Payment Status Failed !!"
                if self.screen == "cart" {
                    self.clearCart()
                }
            }
        }
    }
    
    
    //MARK:- calling API
    func clearCart() {
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.DELET_ALL_CART,postdatadictionary: ["userId" : UserDefaults.standard.string(forKey: "id") ?? ""], isArray: false) { (response) in
            
            if let res = response as? [String : Any] {
                print(res)
                self.hideHUD()
                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                }
            }
        }
    }
    
    
    
    
    
    @objc func redirectToHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}

extension TransactionSuccessViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "cartCell") as? TransactionSuccessCell
        
        if screen == "cart" {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "cartCell") as? TransactionSuccessCell
            cell?.msgLbl.text = self.msg
            cell?.continueShoppingBtn.addTarget(self, action: #selector(redirectToHome), for: .touchUpInside)
            cell?.updateProfileBtn.addTarget(self, action: #selector(redirectToHome), for: .touchUpInside)
            
            cell?.trackOrderBtn.addTarget(self, action: #selector(redirectToHome), for: .touchUpInside)

            
            return cell!
        }
        if screen == "asking" {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "askingCell") as? TransactionSuccessCell
            cell?.msgLbl.text = self.msg
            cell?.goToHome.addTarget(self, action: #selector(redirectToHome), for: .touchUpInside)
            
            
            
            return cell!
            
        }
        
        
        return cell!
    }
    
    
}
