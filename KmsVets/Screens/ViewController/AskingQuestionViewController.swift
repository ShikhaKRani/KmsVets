//
//  AskingQuestionViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AskingQuestionViewController: BaseViewController {
    var nameString : String?
    var mobileString : String?
    var emailString : String?
    var quesString : String?
    var numberofquesString : String?
    var amountToPay  = 0
    var pricePerQuestion : String?
    var order_id : String?
    
//
    
    @IBOutlet weak var askquestionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pricelabelApi()
        
        mobileString = UserDefaults.standard.string(forKey: "mobile") ?? ""
        nameString = UserDefaults.standard.string(forKey: "name") ?? ""
        emailString = UserDefaults.standard.string(forKey: "email") ?? ""
        
        askquestionTableView.separatorStyle = .none
        askquestionTableView.backgroundColor = .tertiarySystemGroupedBackground
        
        
        
    }
    
    //MARK:- PriceApi
    
    func pricelabelApi(){
        let indexPath = IndexPath(row: 0, section: 0)
        self.showHud("Loading...")
        
        let params = ["key": AppConstant.UserKey] as Dictionary<String, String>
        ServiceClient.sendRequest(apiUrl: APIUrl.QUESTION_PRICE,postdatadictionary: params, isArray: false) { (response) in
            
            if let res = response as? [String : Any] {
                print(res)
                self.pricePerQuestion = res["price"] as? String
                DispatchQueue.main.async { () -> Void in
                    
                    if let cell = self.askquestionTableView?.cellForRow(at: indexPath) as? AskQuestionTableViewCell {
                        cell.priceLabel.textAlignment = .center
                        cell.priceLabel.text = self.pricePerQuestion
                    }
                }
                self.hideHUD()
            }
        }
        
    }
    
    //MARK:- Submit button action

    @objc func submitBtnAtion() {
        self.view.endEditing(true)
        
        var count = 0
        if ((nameString?.isEmpty) == nil) {
            count = count + 1
            self.displayMessage(message: "Please enter your full name")
            return
        }
        
        
        if ((emailString?.isEmpty) == nil) {
            
            count = count + 1
            self.displayMessage(message: "Please enter your email")
            return
        }
        if ((quesString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please Write Your Question")
            return
        }
        
        if ((numberofquesString?.isEmpty) == nil){
            
            count = count + 1
            self.displayMessage(message: "Please enter number of question to be asked")
            return
        }
        
        // check if no error
        if count == 0 {
            if ((numberofquesString?.isEmpty) != nil) {
                
                if let no_question = Int(numberofquesString ?? "0") {
                    if let  price = Int(pricePerQuestion ?? "0") {
                        amountToPay = price * no_question
                    }
                }
            }
            
            askQuestionAPICall()
        }
    }
    
    
    //MARK:- askQuestion APi call
    
    
    func askQuestionAPICall() {

        self.showHud("Progress...")
        let params = ["key": AppConstant.UserKey, "name" : nameString ?? "", "user_id": UserDefaults.standard.string(forKey: "id") ?? "","mobile": mobileString ?? "", "email" : emailString ?? "", "no_of_question" : numberofquesString ?? "0" , "amount" : "\(amountToPay)" , "question" : quesString ?? ""]  as! Dictionary<String, String>


       ServiceClient.sendRequest(apiUrl: APIUrl.ASK_Question,postdatadictionary: params, isArray: false) { (response) in

           if let res = response as? [String : Any] {
               print(res)
            self.order_id = res["id"] as? String
            let amount = res["amount"] as? String
            self.hideHUD()
            DispatchQueue.main.async { () -> Void in
                self.redirectToPaymentScreen()
            }
            
            
           }
       }
    }
    
    
    
    //MARK:- Pay U Money
    
    
    func redirectToPaymentScreen() {
        
        let storyBoard = UIStoryboard.init(name: "Payment", bundle: nil)
        if let paymentVC = storyBoard.instantiateViewController(withIdentifier: "PaymentViewController") as? PaymentViewController {
           
            paymentVC.firstName = nameString
            paymentVC.email = emailString
            paymentVC.order_id = order_id
            paymentVC.totalPriceAmount = "\(amountToPay)"
            
            paymentVC.screen = "asking"
            self.navigationController?.pushViewController(paymentVC, animated: true)
        }
        
        
    }
    
    //MARK:- Pay U Money
    
    
    
}

//MARK:- Table View Delegate
extension AskingQuestionViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.askquestionTableView.dequeueReusableCell(withIdentifier: StringConstant.AskQuestionTableViewCell) as? AskQuestionTableViewCell
        
        cell?.nameField.tag = 100
        cell?.quesTextview.tag = 1000
        cell?.mobileField.tag = 101
        cell?.submitButton.tag = 102
        cell?.numberofQuestionField.tag = 103
        
        cell?.nameField.delegate = self
        cell?.emailField.delegate = self
        cell?.numberofQuestionField.delegate = self
        cell?.mobileField.delegate = self
       
        cell?.mobileField.text = mobileString
        cell?.nameField.text = nameString
        cell?.emailField.text = emailString
        cell?.mobileField.isUserInteractionEnabled = false
        
        cell?.quesTextview.layer.cornerRadius = 5
        cell?.quesTextview.layer.borderColor = UIColor.white.cgColor
        cell?.quesTextview.layer.borderWidth = 1
        
        
        cell?.quesTextview.delegate = self
        cell?.quesTextview.text = "Write Down Your Question"
        cell?.quesTextview.textColor = UIColor.lightGray
        
        cell?.chatButton.contentHorizontalAlignment = .left
        cell?.chatButton.contentEdgeInsets =  UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        cell?.chatButton.titleLabel?.lineBreakMode = .byWordWrapping
        
        cell?.submitButton.layer.cornerRadius = 5
        cell?.submitButton.addTarget(self, action: #selector(submitBtnAtion), for: .touchUpInside)
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
//MARK:- TextField Delegate

extension AskingQuestionViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if textField.tag == 100 {
            nameString = textField.text ?? ""
        }
        else if textField.tag == 101 {
            mobileString = textField.text ?? ""
        }
        else if textField.tag == 102 {
            emailString = textField.text ?? ""
        }
        else if textField.tag == 103 {
            numberofquesString = textField.text ?? ""
        }
        
        
    }
}

//MARK:- Textview Delegate

extension AskingQuestionViewController : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.tag == 1000 {
            textView.text  = ""
            textView.textColor = UIColor.black
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.tag == 1000 {
            quesString = textView.text
        }
        
        textView.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        if textView.tag == 1000 {
            if textView.text.count == 0{
                textView.textColor = UIColor.lightGray
                textView.text = "Write Down Your Question"
                textView.resignFirstResponder()
            }
        }
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        if textView.tag == 1000 {
            if textView.text.count == 0{
                textView.textColor = UIColor.lightGray
                textView.text = "Write Down Your Question"
                textView.resignFirstResponder()
            }
        }
        return true
    }
}
