//
//  OrderDetailViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 01/10/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit


class OrderDetailCell : UITableViewCell {
    
    @IBOutlet weak var orderStatusLbl: UILabel!
    @IBOutlet weak var youPaidLbl: UILabel!
    @IBOutlet weak var youSavedLbl: UILabel!
    @IBOutlet weak var repeatOrderBtn: UIButton!
    @IBOutlet weak var cancelOrderBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var unitlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
}



class OrderDetailViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    var orderModel : OrderModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order Details"

    }
    
    
    //order_id
//    func getOrders() {
//        self.showHud("")
//        //182
//        ServiceClient.sendRequest(apiUrl: APIUrl.ORDER_DETAIL,postdatadictionary: ["order_id" : "102"], isArray: false) { (response) in
//
//            print(response)
//            if let res = response as? [[String : Any]] {
//                print(res)
//                if let lastObj = res.last {
//                    if let data = lastObj["data"] as? [[String: Any]] {
//                        for item in data {
//
//                        }
//                    }
//                }
//
//                DispatchQueue.main.async { () -> Void in
//                    self.tblView.reloadData()
//                }
//                self.hideHUD()
//            }
//        }
//    }
    
    
    func repeatOrders() {
        
        self.showHud("")

        ServiceClient.sendRequest(apiUrl: APIUrl.REPEAT_ORDER,postdatadictionary: ["order_id" : "102","userId": UserDefaults.standard.string(forKey: "id") ?? ""], isArray: false) { (response) in
            
            print(response)
            if let res = response as? [String : Any] {
                print(res)
                let responce = res["responce"] as? String
                if responce == "success" {
                    self.displayAlertView(alertType: "Success", message: res["data"] as? String ?? "")
                    self.redirectToCart()
                }
                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                }
                self.hideHUD()
            }
        }
    }
    
    
    func cancelOrders() {
        
        self.showHud("")

        ServiceClient.sendRequest(apiUrl: APIUrl.REPEAT_ORDER,postdatadictionary: ["orderid" : "\(self.orderModel?.order_id ?? "")"], isArray: false) { (response) in
            
            print(response)
            if let res = response as? [String : Any] {
                print(res)
                let responce = res["responce"] as? String
                if responce == "success" {
                    self.displayAlertView(alertType: "Order Status", message: res["data"] as? String ?? "")
                    self.redirectToCart()
                }
                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                }
                self.hideHUD()
            }
        }
    }
    
    
    @objc func redirectToCart() {
        DispatchQueue.main.async { () -> Void in
            let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
            if let cartVC = storyBoard.instantiateViewController(withIdentifier: "ProductCartViewController") as? ProductCartViewController {
                self.navigationController?.pushViewController(cartVC, animated: true)
            }
        }
    }
    
}


extension OrderDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "OrderDetailCell1") as? OrderDetailCell
        if indexPath.section == 0 {
            let cell1 = self.tblView.dequeueReusableCell(withIdentifier: "OrderDetailCell1") as? OrderDetailCell
            
            return cell1!
        }
        else if indexPath.section == 1 {
            let cell2 = self.tblView.dequeueReusableCell(withIdentifier: "OrderDetailCell2") as? OrderDetailCell
            
            return cell2!
        }
        
        return cell!
    }
    
    
}
