//
//  CustomerBasicInfoViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 14/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CustomerBasicInfoViewController: BaseViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var customerName = ""
    var customerEmail = ""
    var customerAddress = ""
    
    @IBOutlet weak var infoTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        setTitleForNavigation(title: "KMS Vets", isHidden: false)
        infoTableView.tableFooterView = UIView()
        infoTableView.separatorStyle = .none
        //fetch data store in Userdefault
        customerName = UserDefaults.standard.string(forKey: "name") ?? ""
        customerEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        customerAddress = UserDefaults.standard.string(forKey: "address") ?? ""

    }
    
    @objc func  validateUserEntry() {
        var count = 0
        
        if customerName.isEmpty {
            count = count + 1
            self.displayMessage(message: "Enter Customer Name")
        }
        if customerEmail.isEmpty {
            count = count + 1
            self.displayMessage(message: "Enter Customer Email")

            
        }
        if customerAddress.isEmpty {
            count = count + 1
            self.displayMessage(message: "Enter Customer Address")
        }
        
        if count == 0 {
            self.updateUserInfo()
        }
    }
    
    
    
    //MARK:- UPDATE PROFILE
    func updateUserInfo() {
        //params
        
        let params = ["key": AppConstant.UserKey, "name" : customerName, "email" : customerEmail, "address" : customerAddress , "userid": UserDefaults.standard.string(forKey: "id") ?? ""] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: APIUrl.PROFILE_UPDATE)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
       
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let response = try JSONSerialization.jsonObject(with: data!) as! [String : Any]
                let successCode = response["code"] ?? ""
               
                if successCode as! String == "200" {
                    UserDefaults.standard.set(self.customerAddress, forKey: "address")
                    UserDefaults.standard.set(self.customerName, forKey: "name")
                    UserDefaults.standard.set(self.customerEmail, forKey: "email")
                    
                    DispatchQueue.main.async { () -> Void in
                        self.redirectToHomeInfoScreen()
                    }
                }else{
                    DispatchQueue.main.async { () -> Void in
                        self.redirectToHomeInfoScreen()
                    }
                }
             
            } catch {
                print(" Parshing Error")
            }
        })
        
        task.resume()
    }
    
    func redirectToHomeInfoScreen() {
        
        let storyBoard = UIStoryboard.init(name: "SideMenu", bundle: nil)
        if let homeinfoViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            
            let navController = UINavigationController.init(rootViewController: homeinfoViewController)
            self.appDelegate?.window?.rootViewController = navController

            
        }
  
        
    }
    
    
}


extension CustomerBasicInfoViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            customerName =  textField.text ?? ""
        }
        else if textField.tag == 101 {
            customerEmail =  textField.text ?? ""
        }
        else if textField.tag == 102 {
            customerAddress =  textField.text ?? ""
        }
    }
}

extension CustomerBasicInfoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.infoTableView.dequeueReusableCell(withIdentifier: StringConstant.CustomerInformationCell) as? CustomerInformationCell
        
        cell?.customerName.tag = 100
        cell?.customerEmail.tag = 101
        cell?.customerAddress.tag = 102
        cell?.customerName.delegate = self
        cell?.customerEmail.delegate = self
        cell?.customerAddress.delegate = self
        
        cell?.customerName.text = customerName
        cell?.customerEmail.text = customerEmail
        cell?.customerAddress.text = customerAddress
        
        cell?.continueButton.addTarget(self, action: #selector(validateUserEntry), for: .touchUpInside)

        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
