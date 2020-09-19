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
        
    }
    
    func apiCall() {
    
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
        else if textField.tag == 103 {
            mobile = textField.text ?? ""
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
        
        cell?.userMobile.isUserInteractionEnabled = false

        cell?.profileupdateButton.addTarget(self, action: #selector(updateBtnAtion), for: .touchUpInside)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


