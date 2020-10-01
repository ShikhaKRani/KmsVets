//
//  ServiceOrderDetailViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 01/10/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit


class ServiceDetailCell : UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!

}
class ServiceOrderDetailViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    var serviceModel : ServiceOrderModel?

    var titleArray = [String]()
    var subTitleArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.tableFooterView = UIView()
        tblView.separatorStyle = .none
        
        self.titleArray.append("Service Category:")
        self.titleArray.append("Name:")
        self.titleArray.append("Mobile:")
        self.titleArray.append("Address:")
        self.titleArray.append("Email:")
        self.titleArray.append("Pet Name:")
        self.titleArray.append("Pet Bridge:")
        self.titleArray.append("Pet Age:")
        self.titleArray.append("Pet ID:")
        self.titleArray.append("Pet Category:")
        self.titleArray.append("Pincode:")
        self.titleArray.append("Booking Date:")
        self.titleArray.append("Service Slot:")
        self.titleArray.append("Service Time:")
        self.titleArray.append("Consultation Charges:")
        self.titleArray.append("Visit Charges:")
        self.titleArray.append("Total Charges:")
        self.titleArray.append("Pet Type:")
        
        self.subTitleArray.append("\(serviceModel?.service_cat ?? "")")
        self.subTitleArray.append("\(serviceModel?.name ?? "")")
        self.subTitleArray.append("\(serviceModel?.mobile ?? "")")
        self.subTitleArray.append("\(serviceModel?.address ?? "")")
        self.subTitleArray.append("\(serviceModel?.email ?? "")")
        self.subTitleArray.append("\(serviceModel?.petname ?? "")")
        self.subTitleArray.append("\(serviceModel?.pet_bride ?? "")")
        self.subTitleArray.append("\(serviceModel?.pet_age ?? "")")
        self.subTitleArray.append("\(serviceModel?.pet_id ?? "")")
        self.subTitleArray.append("\(serviceModel?.pet_category ?? "")")
        self.subTitleArray.append("\(serviceModel?.pincode ?? "")")
        self.subTitleArray.append("\(serviceModel?.bookdate ?? "")")
        self.subTitleArray.append("\(serviceModel?.service ?? "")")
        self.subTitleArray.append("\(serviceModel?.time ?? "")")
        self.subTitleArray.append("\(StringConstant.RuppeeSymbol)\(serviceModel?.delivery_charge ?? "")")
        self.subTitleArray.append("\(StringConstant.RuppeeSymbol)\(serviceModel?.visit_charge ?? "")")
        self.subTitleArray.append("\(StringConstant.RuppeeSymbol)\(serviceModel?.total_charge ?? "")")
        self.subTitleArray.append("\(serviceModel?.pettype ?? "")")
        
        self.title = "Service Detail"
    }
    
}



extension ServiceOrderDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ServiceDetailCell") as? ServiceDetailCell
        
        cell?.titleLbl.text = titleArray[indexPath.row]
        cell?.subTitleLbl.text = subTitleArray[indexPath.row]

        return cell!
    }
    
    
}
