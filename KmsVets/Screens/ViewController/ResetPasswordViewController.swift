//
//  ResetPasswordViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 21/11/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ResetPasswordViewController: BaseViewController {
    
    @IBOutlet weak var otpTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var submitButton:UIButton!
    
    var otpNumber : String?
    var mobileNumber : String?
    
    var pwd : String?
    var otpString : String?
    var confirmPwd : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otpTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        otpTextField.tag = 100
        passwordTextField.tag = 101
        confirmPasswordTextField.tag = 102
        
        self.submitButton.addTarget(self, action: #selector(validateParams), for: .touchUpInside)
        
        
    }
    
    //MARK:- validateParams
    @objc func validateParams(){
        
        var count = 0
        
        if otpString?.count ?? 0 == 0 {
            count = count + 1
            self.view.makeToast("Please enter OTP")
            return
        }
        else{
            if otpString != self.otpNumber {
                count = count + 1
                self.view.makeToast("Please enter correct OTP")
                return
                
            }
        }
        
        if pwd?.count ?? 0  == 0 {
            count += count
        }
        if confirmPwd?.count ?? 0  == 0 {
            count += count
        }
        
        if pwd != confirmPwd {
            count += count
            self.view.makeToast("Password and Confirm password doesn't match")
            return
        }
        
        
        if count == 0 {
            self.resetPasswordAPICall()
        }
    }
    
    //MARK:- resetPasswordAPICall
    func resetPasswordAPICall() {
        
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.RESET_PASSWORD,postdatadictionary: ["mobile" : self.mobileNumber ?? "" , "password": self.pwd ?? ""], isArray: false) { (response) in
            if let respon = response as? [String : Any] {
                print(response)
                self.hideHUD()

                if let res = respon["responce"] as? String {
                    if res == "success" {
                        if let dataDict = respon["data"] as? [String : Any] {
                            UserDefaults.standard.set(dataDict["status"], forKey: "status")
                            UserDefaults.standard.set(dataDict["mobile"], forKey: "mobile")
                            UserDefaults.standard.set(dataDict["zipcode"], forKey: "zipcode")
                            UserDefaults.standard.set(dataDict["password"], forKey: "password")
                            UserDefaults.standard.set(dataDict["country"], forKey: "country")
                            UserDefaults.standard.set(dataDict["id"], forKey: "id")
                            UserDefaults.standard.set(dataDict["unique_code"], forKey: "unique_code")
                            UserDefaults.standard.set(dataDict["gcm_code"], forKey: "gcm_code")
                            UserDefaults.standard.set(dataDict["city"], forKey: "city")
                            UserDefaults.standard.set(dataDict["temp_password"], forKey: "temp_password")
                            UserDefaults.standard.set(dataDict["name"], forKey: "name")
                            UserDefaults.standard.set(dataDict["email"], forKey: "email")
                            UserDefaults.standard.set(dataDict["reg_date"], forKey: "reg_date")
                            UserDefaults.standard.set(dataDict["phone_verified"], forKey: "phone_verified")
                            UserDefaults.standard.set(dataDict["gcm_type"], forKey: "gcm_type")
                            UserDefaults.standard.set(dataDict["state"], forKey: "state")
                            UserDefaults.standard.set(dataDict["address"], forKey: "address")
                            UserDefaults.standard.set(dataDict["username"], forKey: "username")
                        }
                    }
                
                    self.hideHUD()
                    DispatchQueue.main.async { () -> Void in
                        self.redirectToCustomerInfoScreen()
                    }
                    
                }
            }
        }
        
    }
    
    
    func redirectToCustomerInfoScreen() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let customerinfoViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerBasicInfoViewController") as? CustomerBasicInfoViewController {
            self.navigationController?.pushViewController(customerinfoViewController, animated: true)
        }
    }
    
    
}



extension ResetPasswordViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            self.otpString = textField.text
        }
        if textField.tag == 101 {
            self.pwd = textField.text
        }
        
        if textField.tag == 102 {
            self.confirmPwd = textField.text
        }
        
    }
}
