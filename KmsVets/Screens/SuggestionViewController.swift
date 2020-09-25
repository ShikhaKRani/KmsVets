//
//  SuggestionViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 23/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SuggestionViewController: BaseViewController {
    
    
    var nameString : String?
    var mobileString : String?
    var descString : String?
    
    @IBOutlet weak var suggestionTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileString = UserDefaults.standard.string(forKey: "mobile") ?? ""
        nameString = UserDefaults.standard.string(forKey: "name") ?? ""
        // Do any additional setup after loading the view.
    }
    
    @objc func saveBtnAtion() {
        
        
        var count = 0
        if ((nameString?.isEmpty) == nil) {
            count = count + 1
            self.displayMessage(message: "Please enter your full name")
            return
        }
        
        if ((mobileString?.isEmpty) == nil) {
            
            count = count + 1
            self.displayMessage(message: "Please enter your email")
            return
        }
        
        
        if ((descString?.isEmpty) == nil) {
            
            count = count + 1
            self.displayMessage(message: "Please enter description")
            return
        }
        
        if count == 0 {
//            self.submitSuggestionApi()
        }
    }
    
    
    ////MARK:- submit suggestion api
    
//    func submitSuggestionApi() {
//
//        self.showHud("Booking in Progress")
//        let params = ["key": AppConstant.UserKey, "name" : name, "email" : email, "address" : address , "user_id": UserDefaults.standard.string(forKey: "id") ?? "","breed": petsBreed, "description" : descriptionStr ,"mobile": mobile] as Dictionary<String, String>
//
//
//       ServiceClient.sendRequest(apiUrl: APIUrl.BOOK_NEW_PUPPY,postdatadictionary: params, isArray: false) { (response) in
//
//           if let res = response as? [String : Any] {
//               print(res)
//            let message = res["msg"] as? String
//            self.hideHUD()
//
//            self.displayMessage(message: message)
//           }
//       }
//    }
    

}

extension SuggestionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.suggestionTableView.dequeueReusableCell(withIdentifier: "imgCell") as? SuggestionTableViewCell
       // let dict = self.dataArray?[indexPath.row]
        
        

        if indexPath.row == 1 {
            let cell = self.suggestionTableView.dequeueReusableCell(withIdentifier: "fieldCell") as? SuggestionTableViewCell
            
            cell?.nameField.tag = 100
            cell?.commentTextView.tag = 1000
            cell?.mobileField.tag = 101
            cell?.submitButton.tag = 102
                    
            cell?.nameField.layer.cornerRadius = 5
            cell?.nameField.layer.borderColor = UIColor.green.cgColor
            cell?.nameField.layer.borderWidth = 1
            
            cell?.mobileField.layer.cornerRadius = 5
            cell?.mobileField.layer.borderColor = UIColor.green.cgColor
            cell?.mobileField.layer.borderWidth = 1
            
            cell?.commentTextView.layer.cornerRadius = 5
            cell?.commentTextView.layer.borderColor = UIColor.green.cgColor
            cell?.commentTextView.layer.borderWidth = 1
            
            
            cell?.commentTextView.delegate = self
            

            cell?.commentTextView.text = "Enter Your Comment"
            cell?.commentTextView.textColor = UIColor.lightGray
//            cell?.descriptionTextView.layer.borderWidth = 0.4
//            cell?.descriptionTextView.layer.borderColor = UIColor.darkGray.cgColor
//            cell?.descriptionTextView.layer.cornerRadius = 10.0
            
            cell?.nameField.text = nameString
            cell?.mobileField.text = mobileString
            cell?.mobileField.isEnabled = false
            cell?.selectionStyle = .none
            return cell!
        }
        
        
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}

extension SuggestionViewController : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.tag == 1000 {
            textView.text  = ""
            textView.textColor = UIColor.black
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.tag == 1000 {
            descString = textView.text
        }
        
        textView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.tag == 1000 {
            if textView.text.count == 0{
                textView.textColor = UIColor.lightGray
                textView.text = "Description"
                textView.resignFirstResponder()
            }
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView.tag == 1000 {
            if textView.text.count == 0{
                textView.textColor = UIColor.lightGray
                textView.text = "Description"
                textView.resignFirstResponder()
            }
        }
        return true
    }
}

//MARK:-  Textfield Delegate

extension SuggestionViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            nameString = textField.text ?? ""
        }
        else if textField.tag == 101 {
            mobileString = textField.text ?? ""
        }
       
        
        
    }
}
 


