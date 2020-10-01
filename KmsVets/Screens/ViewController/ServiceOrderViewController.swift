//
//  ServiceOrderViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 01/10/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit



class ServiceOrderCell : UITableViewCell {
    @IBOutlet weak var totalChargeLbl: UILabel!
    @IBOutlet weak var petNameLbl: UILabel!
    @IBOutlet weak var petServiceLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
}


class ServiceOrderViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var serviceList = [ServiceOrderModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
        self.title = "Service Order"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getService()
        
    }
    
    
    func getService() {
        
        self.showHud("")
        //182
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_SERVICE,postdatadictionary: ["key": AppConstant.UserKey, "user_id" : ["user_id": UserDefaults.standard.string(forKey: "id") ?? ""]], isArray: true) { (response) in
            
            print(response)
            self.serviceList.removeAll()
            if let res = response as? [[String : Any]] {
                print(res)
                if let lastObj = res.last {
                    if let data = lastObj["data"] as? [[String: Any]] {
                        
                        for item in data {
                            let model = ServiceOrderModel(dict: item)
                            self.serviceList.append(model)
                        }
                    }
                }
                
                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                }
                self.hideHUD()
            }
        }
    }
    
    
}

extension ServiceOrderViewController :UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.serviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ServiceOrderCell") as? ServiceOrderCell
        let model = self.serviceList[indexPath.row]
        
        
        
        if let dateString = model.bookdate {
            cell?.yearLbl.text = self.returnDateFormat(dateString: dateString, dateFormatInServer: "dd/MM/yyyy", expectedFormat: "yyyy")

            cell?.dateLbl.text = self.returnDateFormat(dateString: dateString, dateFormatInServer: "dd/MM/yyyy", expectedFormat: "dd")
            cell?.monthLbl.text = self.returnDateFormat(dateString: dateString, dateFormatInServer: "dd/MM/yyyy", expectedFormat: "MMM")
        }
        
        cell?.detailLbl.layer.borderWidth = 1
        cell?.detailLbl.layer.borderColor = UIColor.black.cgColor
        cell?.totalChargeLbl.text = "\(StringConstant.RuppeeSymbol)\(model.total_charge ?? "0")"
        cell?.petNameLbl.text = "\(model.name ?? "")"
        cell?.petServiceLbl.text = "\(model.service_cat ?? "")"


        cell?.selectionStyle = .none
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(identifier: "ServiceOrderDetailViewController") as? ServiceOrderDetailViewController {
            let model = self.serviceList[indexPath.row]
            vc.serviceModel = model
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
   
    
    
}
