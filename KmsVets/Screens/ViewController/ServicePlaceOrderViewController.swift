//
//  ServicePlaceOrderViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 30/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DropDown
import EzPopup


class ServicePlaceOrderViewController: BaseViewController, MyCalenderProtocol {
   
    @IBOutlet weak var tblView: UITableView!
    
    var dogsCatStr : String?
    var zipcodeFieldStr : String?
    var zipcodeCharge = 0
    var selectDateFieldsStr : String?
    var selecttimeFieldStr : String?
    var distanceChargesStr : String?
    var totalChargesStr : String?
    var deliveryChargesStr : String?
    //----Prev screen info
    var nameString : String?
    var mobileString : String?
    var emailString : String?
    var addressString : String?
    var petnameString : String?
    var petbreedString : String?
    var petageyearString : String?
    var petagemonthString : String?
    var registrationString : String?
    var petregistrationString : String?
    
    var zipcodeArray = [[String : Any]]()
    var petCategoryChargeDict = [String : Any]()
    let dropDown = DropDown();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getZipcode()
    }

    func getZipcode() {
        
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_PINCODE,postdatadictionary: ["key": AppConstant.UserKey], isArray: true) { (response) in
            
            print(response)
            self.zipcodeArray.removeAll()
            if let res = response as? [[String : Any]] {
                print(res)
                if let lastObj = res.last {
                    if let data = lastObj["data"] as? [[String: Any]] {
                        self.zipcodeArray = data
                    }
                }
                
                DispatchQueue.main.async { () -> Void in
                    self.tblView.reloadData()
                }
                self.hideHUD()
            }
        }
    }
    
    
    
    
    func getVisitCharge() {
        //params
        self.view.endEditing(true)
        if ((dogsCatStr?.isEmpty) == nil){
            self.displayMessage(message: "Please select dogs Category")
            return
        }

        if ((registrationString?.isEmpty) == nil){
            self.displayMessage(message: "Please enter pet registration type")
            return
        }
       var pet = ""
        if registrationString == "Not Registered with us" {
            pet = "Not Register"
        }else{
            pet = "Register"

        }
       
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.GetVisit_Charge,postdatadictionary: ["key": AppConstant.UserKey, "pettype" : "\(pet)" , "dog_cat" : "\(dogsCatStr ?? "")"], isArray: true) { (response) in

            print(response)
            self.petCategoryChargeDict = [:]
            if let res = response as? [[String : Any]] {
                print(res)
                if let lastObj = res.last {
                    if let data = lastObj["data"] as? [[String: Any]] {
                        if let lastobj = data.last {
                            self.petCategoryChargeDict = lastobj
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
    
    @objc func selectDateAction(sender : UIButton?) {
        
        let vc = MyCalenderViewController(nibName: "MyCalenderViewController", bundle: nil)
        vc.title = "Date And Time"
        vc.myCalDelegate = self
        let popupVC = PopupViewController(contentController: vc, popupWidth: (UIScreen.main.bounds.size.width)-40, popupHeight: (UIScreen.main.bounds.size.height) - 180)
        popupVC.cornerRadius = 10
        present(popupVC, animated: true)

        
    }
    
    //MARK:- returnSelectedDate Calender protocol
    func returnSelectedDate(selectedDate: String) {
        print(selectedDate)
        selectDateFieldsStr = selectedDate
        DispatchQueue.main.async { () -> Void in
            self.tblView.reloadData()
        }
    }
    
    
    @objc func selectTimeAction(sender : UIButton) {
        
        guard let cell = sender.superview?.superview as? ServicePlaceOrderCell else {
            return
        }
        let timelist = ["3 PM", "4 PM"]
        
        self.dropDown.anchorView = cell.selectCategoryField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = timelist
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            
            self.selecttimeFieldStr = "\(item)"
            
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.tblView.reloadRows(at: [indexPath], with: .none)
        }
        self.dropDown.show()
    }
    
    
    @objc func selectCategoryAction(sender : UIButton) {
        
        guard let cell = sender.superview?.superview as? ServicePlaceOrderCell else {
            return
        }
        let petList = ["House Dogs","Street Dogs"]
        self.dropDown.anchorView = cell.selectCategoryField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = petList
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            self.dogsCatStr = "\(item)"
            self.getVisitCharge()
            
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.tblView.reloadRows(at: [indexPath], with: .none)
        }
        self.dropDown.show()
    }
    
    
    @objc func selectZipcodeAction(sender : UIButton)  {
        
        guard let cell = sender.superview?.superview as? ServicePlaceOrderCell else {
            return
        }
        var zipcodeList = [String]()
        for item in self.zipcodeArray {
            zipcodeList.append(item["pincode"] as? String ?? "")
        }
        self.dropDown.anchorView = cell.selectCategoryField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = zipcodeList
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            
            self.zipcodeFieldStr = "\(item)"
            
            let dict = self.zipcodeArray[index]
            if let charge = dict["rate"] as? String {
                self.zipcodeCharge = Int(charge) ?? 0
            }
            
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.tblView.reloadRows(at: [indexPath], with: .none)
        }
        self.dropDown.show()
    }
    
    
    @objc func placeOrderAction(sender : UIButton) {
        
        
    }
    
    
    
    
    
    
}


extension ServicePlaceOrderViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "ServicePlaceOrderCell") as? ServicePlaceOrderCell
        
        cell?.selectCategoryField.text = dogsCatStr
        cell?.zipcodeField.text = zipcodeFieldStr
        cell?.selectDateField.text = selectDateFieldsStr
        cell?.selecttimeField.text = selecttimeFieldStr
        
        cell?.deliveryChargeLbl.text = "\(StringConstant.RuppeeSymbol)\("0")"
        cell?.distanceChargeLbl.text = "\(StringConstant.RuppeeSymbol)\("0")"
        cell?.totalChargeLbl.text = "\(StringConstant.RuppeeSymbol)\("0")"

        var totalCount = 0
        if let delivery = self.petCategoryChargeDict["visit_charge"] as? String {
            totalCount = Int(delivery) ?? 0
            cell?.deliveryChargeLbl.text = "\(StringConstant.RuppeeSymbol)\(delivery)"
        }
        
        if zipcodeCharge > 0 {
            totalCount = totalCount + zipcodeCharge
            cell?.distanceChargeLbl.text = "\(StringConstant.RuppeeSymbol)\(zipcodeCharge)"
        }
           
        
        
        cell?.totalChargeLbl.text = "\(StringConstant.RuppeeSymbol)\(totalCount)"

        
        
        cell?.selectCategory.addTarget(self, action: #selector(selectCategoryAction(sender:)), for: .touchUpInside)
        cell?.selectDate.addTarget(self, action: #selector(selectDateAction(sender:)), for: .touchUpInside)
        cell?.selectTime.addTarget(self, action: #selector(selectTimeAction(sender:)), for: .touchUpInside)
        cell?.zipcodeBtn.addTarget(self, action: #selector(selectZipcodeAction(sender:)), for: .touchUpInside)
        cell?.placeOrderbtn.addTarget(self, action: #selector(selectZipcodeAction(sender:)), for: .touchUpInside)

        return cell!
    }
    
    
    
}





class ServicePlaceOrderCell: UITableViewCell {
    
    @IBOutlet weak var selectCategoryField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    @IBOutlet weak var selectDateField: UITextField!
    @IBOutlet weak var selecttimeField: UITextField!
    @IBOutlet weak var distanceChargeLbl: UILabel!
    @IBOutlet weak var deliveryChargeLbl: UILabel!
    @IBOutlet weak var totalChargeLbl: UILabel!
    @IBOutlet weak var placeOrderbtn: UIButton!
    @IBOutlet weak var selectCategory: UIButton!
    @IBOutlet weak var zipcodeBtn: UIButton!
    @IBOutlet weak var selectDate: UIButton!
    @IBOutlet weak var selectTime: UIButton!
}

