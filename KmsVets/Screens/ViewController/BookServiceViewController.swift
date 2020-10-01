//
//  BookServiceViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 30/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DropDown
import Alamofire

class BookServiceViewController: BaseViewController {
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
    
    var petRegistered : String?
    var regPetDict : [String: Any] = [:]
    
    @IBOutlet weak var bookServiceTableView: UITableView!
    
    let dropDown = DropDown();
    
    var petArray : [[String: Any]] = [[:]]
    var petageinYear: [String] = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    var petageinMonth: [String] = ["0","1","2","3","4","5","6","7","8","9","10","11","12"]
    var regStatus: [String] = ["Already Registered with us", "Not Registered with us"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Book Services"
        self.fetchPetList()
        petRegistered = ""
        mobileString = UserDefaults.standard.string(forKey: "mobile") ?? ""
        nameString = UserDefaults.standard.string(forKey: "name") ?? ""
        emailString = UserDefaults.standard.string(forKey: "email") ?? ""
        addressString = UserDefaults.standard.string(forKey: "address") ?? ""
        // Do any additional setup after loading the view.
    }
    
    
    @objc func nextBtnAtion() {
        self.view.endEditing(true)
        
        var count = 0
        if ((nameString?.isEmpty) == nil) {
            count = count + 1
            self.displayMessage(message: "Please enter your full name")
            return
        }
        
        
        if ((emailString?.isEmpty) == nil) {
            
            count = count + 1
            self.displayMessage(message: "Please enter your email")
            return
        }
        if ((addressString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please enter address")
            return
        }
        
        if ((petnameString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please enter pet name")
            return
        }
        if ((petbreedString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please Select pet breed")
            return
        }
        if ((petageyearString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please select pet age")
            return
        }
        if ((petagemonthString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please select month")
            return
        }
        if ((registrationString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please enter registration")
            return
        }
       
        // check if no error
        if count == 0 {
                        
            if (self.registrationString == "Already Registered with us") {
                if self.petRegistered == "1" {
                    if let petid = self.regPetDict["id"]  as? String {
                        print(petid)
                    }else{
                        registrationString = "Not Registered with us"
                    }
                }else{
                    self.displayAlertView(alertType: "Alert", message: "Please verify the Pet registration")
                    return
                }
            }
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            if let serviceVC = storyBoard.instantiateViewController(withIdentifier: "ServicePlaceOrderViewController") as? ServicePlaceOrderViewController {
                
                serviceVC.nameString = nameString
                serviceVC.mobileString = mobileString
                serviceVC.emailString = emailString
                serviceVC.addressString = addressString
                serviceVC.petnameString = petnameString
                serviceVC.petbreedString = petbreedString
                serviceVC.petageyearString = petageyearString
                serviceVC.petagemonthString = petagemonthString
                serviceVC.registrationString = registrationString
                serviceVC.petregistrationString = petregistrationString

                self.navigationController?.pushViewController(serviceVC, animated: true)
            }
            
            
        }
    }
    
    
    
    
    
    //Button Action
    
    @objc func dropdownAction (sender : UIButton) {
        guard let cell = sender.superview?.superview as? BookServiceTableViewCell else {
            return
        }
       
        var petList = [String]()
        for petDict in self.petArray {
            let pet_name = petDict["pet_name"] as? String
            petList.append(pet_name?.capitalized ?? "")
        }
        
        print(petList)
        
        self.dropDown.anchorView = cell.petbreedField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = petList
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            
            print(item)
            cell.petbreedField.text = item
            self.petbreedString = item
        }
        self.dropDown.show()
    }
    
    
    @objc func dropdownActionAgeYear (sender : UIButton) {
        guard let cell = sender.superview?.superview as? BookServiceTableViewCell else {
            return
        }
       
        var petList = [String]()
        //for petDict in self.petageinYear {
            //let pet_name = petDict["pet_name"] as? String
            petList.append(contentsOf: petageinYear)
        //}
        
        //print(petList)
        
        self.dropDown.anchorView = cell.petbreedField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = petList
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            
            print(item)
            cell.petageyearField.text = item
            self.petageyearString = item
        }
        self.dropDown.show()
    }
    
    @objc func dropdownActionAgeMonth (sender : UIButton) {
        guard let cell = sender.superview?.superview as? BookServiceTableViewCell else {
            return
        }
       
        var petList = [String]()
        //for petDict in self.petageinYear {
            //let pet_name = petDict["pet_name"] as? String
            petList.append(contentsOf: petageinMonth)
        //}
        
        //print(petList)
        
        self.dropDown.anchorView = cell.petbreedField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = petList
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            
            print(item)
            cell.petagemonthField.text = item
            self.petagemonthString = item
        }
        self.dropDown.show()
    }
    @objc func dropdownActionregStatus (sender : UIButton) {
        guard let cell = sender.superview?.superview as? BookServiceTableViewCell else {
            return
        }
        
        var petList = [String]()
        //for petDict in self.petageinYear {
        //let pet_name = petDict["pet_name"] as? String
        petList.append(contentsOf: regStatus)
        //}
        
        //print(petList)
        
        self.dropDown.anchorView = cell.petbreedField.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = petList
        self.dropDown.selectionAction = { [unowned self] (index, item) in
           
            self.registrationString = "\(item )"
            
            let indexPath = IndexPath(item: sender.tag, section: 0)
            self.bookServiceTableView.reloadRows(at: [indexPath], with: .none)
            
            
        }
        
        self.dropDown.show()
    }
    
    //MARK:- fetchPetList
    func fetchPetList() {
        //params
        let params = ["key": AppConstant.UserKey] as Dictionary<String, String>
        self.showHud("Loading...")

        var request = URLRequest(url: URL(string: APIUrl.GET_PET_LIST)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
       
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                let dict = json[0]
                let dataArray = dict["data"]
                self.petArray = dataArray as! [[String : Any]]
                self.hideHUD()

            } catch {
                print(" Parshing Error")
            }
        })
        
        task.resume()
    }
    
    
    @objc func checkPedId() {
        //params

        self.view.endEditing(true)
        if ((petnameString?.isEmpty) == nil){
            self.displayMessage(message: "Please enter pet Pet Name")
            return
        }

        if ((petregistrationString?.isEmpty) == nil){
            self.displayMessage(message: "Please enter pet registration number")
            return
        }

        self.showHud("Fetching Order")

        ServiceClient.sendRequest(apiUrl: APIUrl.CHECK_PET_ID,postdatadictionary: ["key": AppConstant.UserKey, "petname" : "\(petnameString ?? "")" , "pet_id" : "\(petregistrationString ?? "")"], isArray: true) { (response) in

            print(response)
            self.regPetDict = [:]
            if let res = response as? [[String : Any]] {
                print(res)
                if let lastObj = res.last {
                    if let data = lastObj["data"] as? [[String: Any]] {
                        if let lastobj = data.last {
                            self.regPetDict = lastobj
                        }
                        
                    }
                }
                
                self.petRegistered = "1"
                DispatchQueue.main.async { () -> Void in
                    self.bookServiceTableView.reloadData()
                }
                self.hideHUD()
            }
        }
    }
        

}


//MARK:- Table View Delegate
extension BookServiceViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.bookServiceTableView.dequeueReusableCell(withIdentifier: "BookServiceTableViewCell") as? BookServiceTableViewCell
        
        cell?.nameField.tag = 100
        cell?.mobileField.tag = 101
        cell?.addressField.tag = 102
        cell?.emailField.tag = 103
        cell?.petnameField.tag = 104
        cell?.petbreedField.tag = 105
        cell?.petageyearField.tag = 106
        cell?.petagemonthField.tag = 107
        cell?.registrationField.tag = 108
        cell?.petregistrationField.tag = 109
        cell?.nameField.delegate = self
        cell?.emailField.delegate = self
        cell?.mobileField.delegate = self
        cell?.addressField.delegate = self
        cell?.petnameField.delegate = self
        cell?.petbreedField.delegate = self
        cell?.petageyearField.delegate = self
        cell?.petagemonthField.delegate = self
        cell?.registrationField.delegate = self
        cell?.petregistrationField.delegate = self
        cell?.mobileField.text = mobileString
        cell?.nameField.text = nameString
        cell?.emailField.text = emailString
        cell?.addressField.text = addressString
        cell?.petnameField.text = petnameString
        cell?.petbreedField.text = petbreedString
        cell?.petageyearField.text = petageyearString
        cell?.petagemonthField.text = petagemonthString
        cell?.mobileField.isUserInteractionEnabled = false
        
        if registrationString == "Already Registered with us" {
            cell?.registrationField.text = registrationString
            cell?.petregistrationField.isHidden = false
            cell?.checkButton.isHidden = false
            cell?.verticalSpaceFornextBtn.constant = 65
        }else{
            cell?.registrationField.text = registrationString
            cell?.petregistrationField.isHidden = true
            cell?.checkButton.isHidden = true
            cell?.msgLbl.isHidden = true
            cell?.verticalSpaceFornextBtn.constant = 0
            self.petRegistered = ""
        }
        //coming from server
        if self.petRegistered == "1" {
            if let petid = self.regPetDict["id"]  as? String {
                print(petid)
                    cell?.msgLbl.isHidden = false
                    cell?.msgLbl.text = "Your Pet is Registered with us."
            }else{
                cell?.msgLbl.isHidden = false
                cell?.msgLbl.text = "Your Pet is not Registered with us."
            }
        }

        cell?.petbreedButton.addTarget(self, action: #selector(dropdownAction(sender:)), for: .touchUpInside)
        cell?.peageyearButton.addTarget(self, action: #selector(dropdownActionAgeYear(sender:)), for: .touchUpInside)
        cell?.peagemonthButton.addTarget(self, action: #selector(dropdownActionAgeMonth(sender:)), for: .touchUpInside)
        
        cell?.registrationButton.tag = indexPath.row
        cell?.registrationButton.addTarget(self, action: #selector(dropdownActionregStatus(sender:)), for: .touchUpInside)

       cell?.nextButton.addTarget(self, action: #selector(nextBtnAtion), for: .touchUpInside)
        cell?.checkButton.addTarget(self, action: #selector(checkPedId), for: .touchUpInside)

        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

//MARK:- TextField Delegate

extension BookServiceViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if textField.tag == 100 {
            nameString = textField.text ?? ""
        }
        else if textField.tag == 101 {
            mobileString = textField.text ?? ""
        }
        else if textField.tag == 102 {
            addressString = textField.text ?? ""
        }
        else if textField.tag == 103 {
            emailString = textField.text ?? ""
        }
        else if textField.tag == 104 {
            petnameString = textField.text ?? ""
        }
        else if textField.tag == 105 {
            petbreedString = textField.text ?? ""
        }
        else if textField.tag == 106 {
            petageyearString = textField.text ?? ""
        }
        else if textField.tag == 107 {
            petagemonthString = textField.text ?? ""
        }
        else if textField.tag == 108 {
            registrationString = textField.text ?? ""
        }
        else if textField.tag == 109 {
            petregistrationString = textField.text ?? ""
        }
        
        
    }
}



