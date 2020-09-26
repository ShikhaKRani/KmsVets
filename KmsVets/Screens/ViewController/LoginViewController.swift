//
//  LoginViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 12/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Alamofire


class LoginViewController: BaseViewController{

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var lineView: UIView!
    override func viewDidLoad() {
       
        super.viewDidLoad()
        roundView.layer.borderWidth = 1
        roundView.layer.borderColor = self.setThemeColor().cgColor
        phoneTextField.delegate = self
        phoneTextField.tag = 100
        navigationItem.hidesBackButton = true
        setTitleForNavigation(title: "KMS Vets", isHidden: false)
        if phoneTextField.text == ""{
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor.gray
        }
        
        self.view.insertSubview(self.roundView!, at: 0)
        nextBtn.addTarget(self, action: #selector(redirectToOTPScreen), for: .touchUpInside)
    }
    
    
    
    
    @objc func redirectToOTPScreen(sender : UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let getotpViewController = storyBoard.instantiateViewController(withIdentifier: "GetOTPViewController") as? GetOTPViewController {
            
            getotpViewController.mobileNumber = phoneTextField.text
           
            self.navigationController?.pushViewController(getotpViewController, animated: true)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
          
        
        let charsLimit = 10
        let startingLength = phoneTextField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace =  range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        
        if newLength >= 1 {
           lineView.backgroundColor = setThemeColor()
        }else{
            lineView.backgroundColor = UIColor.gray
        }

        if newLength >= 10 {
            nextBtn.isEnabled = true
            nextBtn.backgroundColor = setThemeColor()
            
        } else {
            nextBtn.isEnabled = false
            nextBtn.backgroundColor = UIColor.gray
            
        }
        
        
        return newLength <= charsLimit
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
