//
//  GetOTPViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 13/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Alamofire

class GetOTPViewController: BaseViewController {

    @IBOutlet weak var roundView: UIView!
    
    @IBOutlet weak var otpTextfield: UITextField!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var resendButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    var mobileNumber:String?
    var randomNumber:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundView.layer.cornerRadius = 20
        roundView.layer.borderWidth = 1
        roundView.layer.borderColor = self.setThemeColor().cgColor
        lineView.backgroundColor = setThemeColor()
        navigationItem.hidesBackButton = true
        setTitleForNavigation(title: "KMS Vets", isHidden: false)
        otpTextfield.attributedPlaceholder = NSAttributedString(text: "Enter OTP", aligment: .center, color:UIColor.gray)
        otpTextfield.delegate = self
        
        otpTextfield.textAlignment = .left
        otpTextfield.contentVerticalAlignment = .top
        otpTextfield.textAlignment = .center
        
        self.view.insertSubview(self.roundView!, at: 0)
        infoLabel.text = "We have send an SMS at +91 \(mobileNumber ?? "")  With an Alternative Password"
        infoLabel.numberOfLines = 0
        
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)

        self.getOtpApi()
        
    }
    
    
    @objc func doneButtonAction(sender : UIButton) {
        
        if randomNumber == self.otpTextfield.text {
            self.fetchUserDetails(mobile: mobileNumber)
        }else{
            self.displayMessage(message: "Please enter correct OTP")
        }
    }
    
    
    
    func redirectToCustomerInfoScreen() {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let customerinfoViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerBasicInfoViewController") as? CustomerBasicInfoViewController {
            self.navigationController?.pushViewController(customerinfoViewController, animated: true)
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
  
    
   
    func getOtpApi() {
        
        self.showHud("Loading...")
        randomNumber = self.random()
        AF.request(APIUrl.GET_OTP, method: .post, parameters: ["authkey": "262913AkeGtTka5c6567fb","route": "4", "sender": "WISDOM", "country": "91", "message": "Your OTP is \(randomNumber!)", "mobiles": self.mobileNumber ?? ""],encoding: URLEncoding.default, headers: nil).responseString { (response) in
            print("--OTP ->\(self.randomNumber ?? ""),\(response)")
            self.hideHUD()
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

extension GetOTPViewController: UITextFieldDelegate {
    
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
     
        let charsLimit = 4
        let startingLength = otpTextfield.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        

        if newLength >= 4 {
            doneButton.isEnabled = true
            doneButton.backgroundColor = setThemeColor()
            
        } else {
            doneButton.isEnabled = false
            doneButton.backgroundColor = UIColor.gray
            
        }
        
        
        return newLength <= charsLimit
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}

