//
//  ProfileViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 17/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    var fullnameStr = ""
    var userName = ""
    var email = ""
    var mobile = ""
    var address = ""
    var zipcode = ""
    var city = ""
    
    
    @IBOutlet weak var profileTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullnameStr = UserDefaults.standard.string(forKey: "name") ?? ""
        userName = UserDefaults.standard.string(forKey: "username") ?? ""
        email = UserDefaults.standard.string(forKey: "email") ?? ""
        mobile = UserDefaults.standard.string(forKey: "mobile") ?? ""
        address = UserDefaults.standard.string(forKey: "address") ?? ""
        zipcode = UserDefaults.standard.string(forKey: "zipcode") ?? ""
        city = UserDefaults.standard.string(forKey: "city") ?? ""
        
        self.title = "My Profile"

    }
    
    
    @objc func updateBtnAtion() {
        
        
        var count = 0
        if fullnameStr.isEmpty {
            count = count + 1
            self.displayMessage(message: "Please enter your full name")
            return
        }
        if userName.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your username")
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
        if city.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your city")
            return
        }
        
        if count == 0 {
            self.updateUserDetails()
        }
    }
    
          //MARK:- Fetch user details after login
    func updateUserDetails() {
        
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
                           
               self.hideHUD()

           }
       }
    }
}

extension ProfileViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            fullnameStr = textField.text ?? ""
        }
        else if textField.tag == 101 {
            userName = textField.text ?? ""
        }
        else if textField.tag == 102 {
            email = textField.text ?? ""
        }
        else if textField.tag == 104 {
            address = textField.text ?? ""
        }
        else if textField.tag == 105 {
            zipcode = textField.text ?? ""
        }
        else if textField.tag == 106 {
            city = textField.text ?? ""
        }
        
        
        
    }
    
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.profileTableView.dequeueReusableCell(withIdentifier: StringConstant.ProfileViewTableViewCell) as? ProfileViewTableViewCell
        
        cell?.userName.delegate = self
        cell?.fullName.delegate = self
        cell?.userEmail.delegate = self
        cell?.userZipcode.delegate = self
        cell?.userAddress.delegate = self
        cell?.userCity.delegate = self
        cell?.userMobile.delegate = self
        
        cell?.fullName.text = fullnameStr
        cell?.userName.text = userName
        cell?.userEmail.text = email
        cell?.userMobile.text = mobile
        cell?.userAddress.text = address
        cell?.userZipcode.text = zipcode
        cell?.userCity.text = city
        
        cell?.userMobile.isUserInteractionEnabled = false
        
        cell?.profileupdateButton.addTarget(self, action: #selector(updateBtnAtion), for: .touchUpInside)
        cell?.selectionStyle = .none
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


