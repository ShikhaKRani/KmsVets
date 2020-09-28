//
//  ConfirmAddressViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 28/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit


class ConfirmAddressViewController: BaseViewController {
    @IBOutlet weak var tblView: UITableView!
    
    var fullnameStr = ""
    var email = ""
    var mobile = ""
    var address = ""
    var zipcode = ""
    var landmark = ""
    var userName = ""
    var city = ""
    
    var totalAmount : Int?
    var cartItemsArray : [CartModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        fullnameStr = UserDefaults.standard.string(forKey: "name") ?? ""
        userName = UserDefaults.standard.string(forKey: "username") ?? ""
        email = UserDefaults.standard.string(forKey: "email") ?? ""
        mobile = UserDefaults.standard.string(forKey: "mobile") ?? ""
        address = UserDefaults.standard.string(forKey: "address") ?? ""
        zipcode = UserDefaults.standard.string(forKey: "zipcode") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        
        
        self.tblView.reloadData()
    }
    
    
    @objc func updateBtnAtion() {
        self.view.endEditing(true)
        var count = 0
        if fullnameStr.isEmpty {
            count = count + 1
            self.displayMessage(message: "Please enter your full name")
            return
        }
        
        if email.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your email")
            return
        }
        if mobile.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your mobile number")
            return
        }
        if address.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your address")
            return
        }
        if zipcode.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your zipcode")
            return
        }
        if landmark.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your landmark")
            return
        }
        
        if count == 0 {
            self.updateUserDetailsAndContinue()
        }
    }
    
    func updateUserDetailsAndContinue() {
        self.showHud("")

        let params = ["key": AppConstant.UserKey, "name" : fullnameStr,"username" : userName, "email" : email, "address" : address , "zipcode" : zipcode, "city": city, "userid": UserDefaults.standard.string(forKey: "id") ?? ""] as Dictionary<String, String>
        
       ServiceClient.sendRequest(apiUrl: APIUrl.PROFILE_UPDATE,postdatadictionary: params, isArray: false) { (response) in
           
           if let reponse = response as? [String : Any] {
               print(reponse)
            self.hideHUD()
            self.fetchUserDetails()
           }
       }
    }
    
    //MARK:- Fetch user details after login
   func fetchUserDetails() {
       self.showHud("")
       ServiceClient.sendRequest(apiUrl: APIUrl.LOGIN_URL,postdatadictionary: ["mobile" : mobile ], isArray: false) { (response) in
          
          if let reponse = response as? [String : Any] {
              print(response)
              let dataDict = reponse["data"] as? [String: Any]
              UserDefaults.standard.set(dataDict?["status"], forKey: "status")
              UserDefaults.standard.set(dataDict?["mobile"], forKey: "mobile")
              UserDefaults.standard.set(dataDict?["zipcode"], forKey: "zipcode")
              UserDefaults.standard.set(dataDict?["password"], forKey: "password")
              UserDefaults.standard.set(dataDict?["country"], forKey: "country")
              UserDefaults.standard.set(dataDict?["id"], forKey: "id")
              UserDefaults.standard.set(dataDict?["unique_code"], forKey: "unique_code")
              UserDefaults.standard.set(dataDict?["gcm_code"], forKey: "gcm_code")
              UserDefaults.standard.set(dataDict?["city"], forKey: "city")
              UserDefaults.standard.set(dataDict?["temp_password"], forKey: "temp_password")
              UserDefaults.standard.set(dataDict?["name"], forKey: "name")
              UserDefaults.standard.set(dataDict?["email"], forKey: "email")
              UserDefaults.standard.set(dataDict?["reg_date"], forKey: "reg_date")
              UserDefaults.standard.set(dataDict?["phone_verified"], forKey: "phone_verified")
              UserDefaults.standard.set(dataDict?["gcm_type"], forKey: "gcm_type")
              UserDefaults.standard.set(dataDict?["state"], forKey: "state")
              UserDefaults.standard.set(dataDict?["address"], forKey: "address")
              UserDefaults.standard.set(dataDict?["username"], forKey: "username")
            DispatchQueue.main.async { () -> Void in
                self.redirectToPlaceOrderScreen()

            }
              self.hideHUD()

          }
      }
   }
    
    func redirectToPlaceOrderScreen() {
        
        let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
        if let placeOrderVc = storyBoard.instantiateViewController(withIdentifier: "PlaceOrderViewController") as? PlaceOrderViewController {
            
            placeOrderVc.totalAmount = totalAmount
            placeOrderVc.cartItemsArray = cartItemsArray

            self.navigationController?.pushViewController(placeOrderVc, animated: true)
        }
        
    }
    
}




//MARK:-

extension ConfirmAddressViewController :  UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "AddressCell") as? AddressCell
        
        cell?.nameField.delegate = self
        cell?.mobileField.delegate = self
        cell?.addressField.delegate = self
        cell?.landmarkField.delegate = self
        cell?.zipcodeField.delegate = self
        cell?.emailField.delegate = self
        
        
        cell?.nameField.tag = 100
        cell?.mobileField.tag = 101
        cell?.addressField.tag = 102
        cell?.landmarkField.tag = 103
        cell?.zipcodeField.tag = 104
        cell?.emailField.tag = 105
        
        
        
        
        cell?.nameField.text = fullnameStr
        cell?.emailField.text = email
        cell?.mobileField.text = mobile
        cell?.addressField.text = address
        cell?.zipcodeField.text = zipcode
        cell?.landmarkField.text = landmark
        cell?.mobileField.isUserInteractionEnabled = false
        
        cell?.continueBtn.addTarget(self, action: #selector(updateBtnAtion), for: .touchUpInside)
        cell?.selectionStyle = .none
        return cell!
    }
    
    
}

extension ConfirmAddressViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            fullnameStr = textField.text ?? ""
        }
        else if textField.tag == 101 {
            mobile = textField.text ?? ""
        }
        else if textField.tag == 102 {
            address = textField.text ?? ""
        }
        else if textField.tag == 103 {
            landmark = textField.text ?? ""
        }
        else if textField.tag == 104 {
            zipcode = textField.text ?? ""
        }
        else if textField.tag == 105 {
            email = textField.text ?? ""
        }
    }
    
}

//MARK:-
class AddressCell : UITableViewCell {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var landmarkField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
}
