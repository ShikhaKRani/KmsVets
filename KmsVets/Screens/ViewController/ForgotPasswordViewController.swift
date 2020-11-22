//
//  ForgotPasswordViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 21/11/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire

class ForgotPasswordViewController: BaseViewController {
    @IBOutlet weak var phoneTextField : UITextField!
    @IBOutlet weak var submitButton : UIButton!
    
    var mobileNumber : String?
    var randomNumber:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTextField.delegate = self
        phoneTextField.tag = 100
        self.submitButton.addTarget(self, action: #selector(validateParams), for: .touchUpInside)
        
    }
    
    @objc func validateParams() {
        
        self.view.endEditing(true)
        var count = 0
        if self.mobileNumber?.count != 10 {
            count  = count + 1
        }
        
        if count == 0 {
            self.forgotPasswordAPI(mobile: mobileNumber)
        }
    }
    
    func redirectToResetPasswordScreen() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let loginOTPVC = storyBoard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as? ResetPasswordViewController {
            loginOTPVC.otpNumber = self.randomNumber
            loginOTPVC.mobileNumber = self.mobileNumber
            self.navigationController?.pushViewController(loginOTPVC, animated: true)
        }
    }
    
    
    
    func forgotPasswordAPI(mobile : String?) {
       self.showHud("Loading...")
        ServiceClient.sendRequest(apiUrl: APIUrl.FORGOT_PASSWORD,postdatadictionary: ["mobile" : mobile ?? ""], isArray: false) { (response) in
           
           if let respon = response as? [String : Any] {
               print(response)
            
            let res = respon["responce"]
            if res as! String  == "success"{
                self.hideHUD()
            
            }
            
            self.getOtpApi()
            DispatchQueue.main.async { () -> Void in
                self.hideHUD()
            }
           }
       }
    }
 
    func getOtpApi() {
        
        self.showHud("Loading...")
        randomNumber = self.random()
        AF.request(APIUrl.GET_OTP, method: .post, parameters: ["authkey": "262913AkeGtTka5c6567fb","route": "4", "sender": "WISDOM", "country": "91", "message": "Your OTP is \(randomNumber!)", "mobiles": self.mobileNumber ?? ""],encoding: URLEncoding.default, headers: nil).responseString { (response) in
            print("--OTP ->\(self.randomNumber ?? ""),\(response)")
            self.hideHUD()
            
            DispatchQueue.main.async { () -> Void in
                self.hideHUD()
                if self.randomNumber?.count ?? 0 > 0 {
                    self.redirectToResetPasswordScreen()

                }
            }
            
        }
    }
    
    func random() -> String {
        var result = ""
        repeat {
            result = String(format:"%04d", arc4random_uniform(10000) )
        } while result.count < 4 || Int(result)! < 1000
        print(result)
        return result
    }
    
}

extension ForgotPasswordViewController : UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            self.mobileNumber = textField.text
        }
    }
}

