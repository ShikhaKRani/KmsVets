//
//  OrderDetailViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 01/10/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit


class OrderDetailCell : UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var unitlbl: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
}



class OrderDetailViewController: BaseViewController {

    @IBOutlet weak var orderStatusLbl: UILabel!
    @IBOutlet weak var youPaidLbl: UILabel!
    @IBOutlet weak var youSavedLbl: UILabel!
    @IBOutlet weak var repeatOrderBtn: UIButton!
    @IBOutlet weak var cancelOrderBtn: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    var orderModel : OrderModel?
    var itemArray = [[String: Any]]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Order Details"
        self.getOrders()
        self.setUp()

    }
    
    func setUp() {
        self.tblView.tableFooterView = UIView()
        
        youPaidLbl.text = "\(StringConstant.RuppeeSymbol)\((orderModel?.total_price ?? ""))"
        youSavedLbl.text = "\(StringConstant.RuppeeSymbol)\((orderModel?.discount ?? ""))"
        if orderModel?.order_status == "0" {
            cancelOrderBtn.isHidden = true
        }
        else{
            cancelOrderBtn.isHidden = false
        }
        
        orderStatusLbl.textColor = .lightGray
        if orderModel?.order_status == "0" {
            orderStatusLbl.text = "Order Pending"
        }
        else if orderModel?.order_status == "1" {
            orderStatusLbl.text = "Order Confirmed"
        }
        else if orderModel?.order_status == "2" {
            orderStatusLbl.text = "Order Cancelled"
        }
        else  if orderModel?.order_status == "3" {
            orderStatusLbl.text = "Order Delivered"
        }
        else if orderModel?.order_status == "4" {
            orderStatusLbl.text = "Order Completed"
        }
        cancelOrderBtn.addTarget(self, action: #selector(cancelOrders), for: .touchUpInside)
        repeatOrderBtn.addTarget(self, action: #selector(repeatOrders), for: .touchUpInside)
    }
    
    func getOrders() {
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.ORDER_DETAIL,postdatadictionary: ["order_id" : "\(self.orderModel?.order_id ?? "")" ], isArray: false) { (response) in

            print(response)
            if let res = response as? [String : Any] {
                print(res)
                    if let data = res["data"] as? [[String: Any]] {
                        for item in data {
                            self.itemArray.append(item)
                        }
                    }

                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                }
                self.hideHUD()
            }
        }
    }
    
    
    @objc  func repeatOrders() {
        
        self.showHud("")

        ServiceClient.sendRequest(apiUrl: APIUrl.REPEAT_ORDER,postdatadictionary: ["orderid" : "102","userId": UserDefaults.standard.string(forKey: "id") ?? ""], isArray: false) { (response) in
            
            print(response)
            if let res = response as? [String : Any] {
                print(res)
                let responce = res["responce"] as? String
                if responce == "success" {
                    self.redirectToCart()
                    self.displayMessage(message: res["data"] as? String ?? "")
                }
                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                }
                self.hideHUD()
            }
        }
    }
    
    
    @objc func cancelOrders() {
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "order") as? OrderDetailCell
            
        let dict = self.itemArray[indexPath.row]
        
        let urlString  =  "\(AppURL.ICON_URL)\(dict["image"] as? String ?? "")"
        cell?.img.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
        cell?.titleLbl.text = dict["title"] as? String
        cell?.unitlbl.text = "\(dict["title"] as? String ?? "") Unit"
        cell?.pricelbl.text = "\(StringConstant.RuppeeSymbol)\(dict["price"] as? String ?? "")"

        return cell!
    }
    
    
}
