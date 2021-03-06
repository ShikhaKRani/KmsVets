//
//  OrderViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 29/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit


class OrderCell : UITableViewCell {
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var orderStatuslbl: UILabel!
    @IBOutlet weak var deliveredByLbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var orderIdLbl: UILabel!
    @IBOutlet weak var amountPaidLbl: UILabel!
    @IBOutlet weak var deliveryChargeLbl: UILabel!
    @IBOutlet weak var totalAmountLbl: UILabel!
    @IBOutlet weak var repeatLbl: UILabel!

}

class OrderViewController: BaseViewController {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var img: UIImageView!

    var orderDataArray = [OrderModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        img.isHidden = true
        self.getOrder()
        tblView.tableFooterView = UIView()
        self.title = "My Orders"

    }
    
    func getOrder() {
        
        self.showHud("Fetching Order")
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_ORDER,postdatadictionary: ["user_id": UserDefaults.standard.string(forKey: "id") ?? ""], isArray: false) { (response) in
            if let res = response as? [String : Any] {
                print(res)
                if let data = res["data"] as? [[String: Any]] {
                    self.orderDataArray.removeAll()
                    for item in data  {
                        let model = OrderModel(dict: item)
                        self.orderDataArray.append(model)
                    }
                }
                
                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                    if self.orderDataArray.count > 0 {
                        self.img.isHidden = true
                    }else{
                        self.img.isHidden = false
                    }
                }
                self.hideHUD()
            }else{
                self.hideHUD()
            }
        }
    }
    
    
}


extension OrderViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orderDataArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "OrderCell") as? OrderCell
        
        let model = self.orderDataArray[indexPath.section]
        let urlString  =  "\(AppURL.ICON_URL)\(model.image ?? "")"
        cell?.img.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
        cell?.timeLbl.text = "\(model.delivery_date ?? "")   \(model.delivery_time ?? "")"
        cell?.timeLbl.textColor  = self.setThemeColor()
        cell?.deliveredByLbl.text = "Delivered By MedHealth"
        cell?.titleLbl.text = model.title
        cell?.orderIdLbl.text = "ORDER ID : \(model.recipt_no ?? "")"
        cell?.deliveryChargeLbl.text = "\(StringConstant.RuppeeSymbol)\(model.delivery_charge ?? "")"
        cell?.amountPaidLbl.text = "\(StringConstant.RuppeeSymbol)\(model.total_price ?? "")"
        
        if model.order_status == "0" {
            cell?.orderStatuslbl.text = "Order Pending"
        }
        else if model.order_status == "1" {
            cell?.orderStatuslbl.text = "Order Confirmed"
        }
        else if model.order_status == "2" {
            cell?.orderStatuslbl.text = "Order Cancelled"
        }
        else  if model.order_status == "3" {
            cell?.orderStatuslbl.text = "Order Delivered"
        }
        else if model.order_status == "4" {
            cell?.orderStatuslbl.text = "Order Completed"
        }
        
        cell?.repeatLbl.layer.cornerRadius = 5
        cell?.repeatLbl.layer.borderWidth = 2
        cell?.repeatLbl.layer.borderColor = self.setThemeColor().cgColor
        cell?.repeatLbl.textColor = self.setThemeColor()
        
        let delivery = Int(model.delivery_charge ?? "0") ?? 0
        let price = Int(model.total_price ?? "0") ?? 0
        let final = delivery + price
        cell?.totalAmountLbl.text = "\(StringConstant.RuppeeSymbol)\(final)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let serviceVC = storyBoard.instantiateViewController(withIdentifier: "OrderDetailViewController") as? OrderDetailViewController {
            let model = self.orderDataArray[indexPath.row]
            serviceVC.orderModel = model
            self.navigationController?.pushViewController(serviceVC, animated: true)
        }

    }
    
}
