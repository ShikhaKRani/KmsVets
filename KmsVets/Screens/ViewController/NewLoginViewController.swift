//
//  NewLoginViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 21/11/20.
//  Copyright © 2020 Shikha. All rights reserved.
//


import UIKit
import IQKeyboardManagerSwift
import SwiftPhoneNumberFormatter


class LoginTableViewCell: UITableViewCell{
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var forgotbutton: UIButton!
    @IBOutlet weak var nextbutton: UIButton!
    @IBOutlet weak var loginWithOtpbutton: UIButton!
    @IBOutlet weak var skipbutton: UIButton!
    @IBOutlet weak var registerbutton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
}

class NewLoginViewController: BaseViewController {

    @IBOutlet weak var logintblView: UITableView!
    var mobileNumber : String?
    var passowrd : String?
    
    var demoMobileNumber = "8767854111"
    var demorandomNumber = "1212"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    @objc func redirectToRegisterPage() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let registerVC = storyBoard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
    @objc func redirectToLoginwithOTP() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let loginOTPVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(loginOTPVC, animated: true)
        }
    }
    @objc func redirectToForgot() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let forgotVC = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            self.navigationController?.pushViewController(forgotVC, animated: true)
        }
    }
    func redirectToCustomerInfoScreen() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let customerinfoViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerBasicInfoViewController") as? CustomerBasicInfoViewController {
            self.navigationController?.pushViewController(customerinfoViewController, animated: true)
        }
    }
    
    @objc func validateLogin() {
        
        self.view.endEditing(true)
        
        
        var count = 0
        if self.mobileNumber?.count != 10 {
            count  = count + 1
        }
        if self.passowrd?.count ?? 0 < 4 {
            count  = count + 1
        }
        
        if count == 0 {
            
            if self.mobileNumber == demoMobileNumber {
                self.fetchUserDetails(mobile: mobileNumber)
            }else{
                self.validateLoginCredential(mobile: mobileNumber, password: passowrd)
            }
            
            
        }
        
        
    }
    
    func validateLoginCredential(mobile : String?, password : String?) {
       self.showHud("Loading...")
        ServiceClient.sendRequest(apiUrl: APIUrl.LOGIN,postdatadictionary: ["mobile" : mobile ?? "", "password" :password ?? ""], isArray: false) { (response) in
           
           if let reponse = response as? [String : Any] {
               print(response)
            
            let res = reponse["responce"]
            if res as! String == "success"{
            
               let dataDict = reponse["data"] as? [String: Any]
               UserDefaults.standard.set(dataDict?["id"], forKey: "id")
               UserDefaults.standard.set(dataDict?["username"], forKey: "username")
               UserDefaults.standard.set(dataDict?["unique_code"], forKey: "unique_code")
               UserDefaults.standard.set(dataDict?["email"], forKey: "email")
               UserDefaults.standard.set(dataDict?["name"], forKey: "name")
               UserDefaults.standard.set(dataDict?["mobile"], forKey: "mobile")
               UserDefaults.standard.set(dataDict?["address"], forKey: "address")
               UserDefaults.standard.set(dataDict?["state"], forKey: "state")
               UserDefaults.standard.set(dataDict?["country"], forKey: "country")
               UserDefaults.standard.set(dataDict?["zipcode"], forKey: "zipcode")
               UserDefaults.standard.set(dataDict?["city"], forKey: "city")
               UserDefaults.standard.set(dataDict?["password"], forKey: "password")
               UserDefaults.standard.set(dataDict?["temp_password"], forKey: "temp_password")
               UserDefaults.standard.set(dataDict?["image"], forKey: "image")
               UserDefaults.standard.set(dataDict?["phone_verified"], forKey: "phone_verified")
               UserDefaults.standard.set(dataDict?["reg_date"], forKey: "reg_date")
               UserDefaults.standard.set(dataDict?["status"], forKey: "status")
               UserDefaults.standard.set(dataDict?["gcm_code"], forKey: "gcm_code")
               UserDefaults.standard.set(dataDict?["gcm_type"], forKey: "gcm_type")
                
                self.hideHUD()
                DispatchQueue.main.async { () -> Void in
                    self.redirectToCustomerInfoScreen()
                }
            }
            else{
                self.hideHUD()
                DispatchQueue.main.async { () -> Void in
                    self.view.makeToast(" User not found ")
                }
                
            }
            
               
               
           }
       }
    }
 
    
    //MARK:- Fetch user details after login
   func fetchUserDetails(mobile : String?) {
      self.showHud("Loading...")
      ServiceClient.sendRequest(apiUrl: APIUrl.LOGIN_URL,postdatadictionary: ["mobile" : mobile ?? ""], isArray: false) { (response) in
          
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
              DispatchQueue.main.async { () -> Void in
                  self.redirectToCustomerInfoScreen()
              }
          }
      }
   }
    
    
}
extension NewLoginViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            self.passowrd = textField.text
        }
        if textField.tag == 101 {
            self.mobileNumber = textField.text
        }
    }
}

extension NewLoginViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.logintblView.dequeueReusableCell(withIdentifier: "LoginTableViewCell") as? LoginTableViewCell
        
        cell?.passwordTextField.tag = 100
        cell?.passwordTextField.delegate = self
        cell?.numberTextField.tag = 101
        cell?.numberTextField.delegate = self
        
        cell?.self.nextbutton.addTarget(self, action: #selector(validateLogin), for: .touchUpInside)

        
        
        
        cell?.self.registerbutton.addTarget(self, action: #selector(redirectToRegisterPage), for: .touchUpInside)
        cell?.self.loginWithOtpbutton.addTarget(self, action: #selector(redirectToLoginwithOTP), for: .touchUpInside)
        cell?.self.forgotbutton.addTarget(self, action: #selector(redirectToForgot), for: .touchUpInside)
        
        cell!.selectionStyle = .none
        return cell!
    }
    
    
}





    

