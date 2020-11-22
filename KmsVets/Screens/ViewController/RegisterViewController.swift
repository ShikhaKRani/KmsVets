//
//  RegisterViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 21/11/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {    
    @IBOutlet weak var tblView: UITableView!

    var name : String?
    var phoneNumber : String?
    var pwd : String?
    var confirmPwd : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK:- validateParams
    @objc func validateParams(){
        
        self.view.endEditing(true)
        var count = 0
        if name?.count ?? 0  == 0 {
            count += count
            self.view.makeToast("Please enter name")
            return
        }
        
        
        if phoneNumber?.count ?? 0  != 10 {
            count += count
            self.view.makeToast("Please enter correct mobile number ")
            return
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
            self.signUpAPICall()
        }
    }

    
    //MARK:- signUpAPICall
    func signUpAPICall() {
        
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.SIGN_UP,postdatadictionary: ["mobile" : self.phoneNumber ?? "" , "password": self.pwd ?? "", "name": self.name ?? "", "type" : "0"], isArray: false) { (response) in
            if let respon = response as? [String : Any] {
                print(response)
                self.hideHUD()

                if let res = respon["responce"] as? String {
                    if res == "success" {
                        DispatchQueue.main.async { () -> Void in
                            self.redirectToOTPScreen()
                        }
                    }else{
                        DispatchQueue.main.async { () -> Void in
                            if let msg = respon["data"] as? String {
                                self.view.makeToast(msg)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @objc func redirectToOTPScreen() {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let getotpViewController = storyBoard.instantiateViewController(withIdentifier: "GetOTPViewController") as? GetOTPViewController {
            self.navigationController?.pushViewController(getotpViewController, animated: true)
        }
    }
        
}

extension RegisterViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "NewRegisterTableViewCell") as? NewRegisterTableViewCell
        
        cell?.nameField.tag = 100
        cell?.phoneField.tag = 101
        cell?.passwordField.tag = 102
        cell?.confirmPasswordField.tag = 103
        cell?.nameField.delegate = self
        cell?.phoneField.delegate = self
        cell?.passwordField.delegate = self
        cell?.confirmPasswordField.delegate = self
       
        cell?.registerButton.addTarget(self, action: #selector(validateParams), for: .touchUpInside)
        cell!.selectionStyle = .none
        return cell!
    }
    
    
}


extension RegisterViewController : UITextFieldDelegate{
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        
       
        if textField.tag == 100 {
            self.name = textField.text
        }
        if textField.tag == 101 {
            self.phoneNumber = textField.text
        }
        
        if textField.tag == 102 {
            self.pwd = textField.text
        }
        if textField.tag == 103 {
            self.confirmPwd = textField.text
        }
       
        
    }
}

