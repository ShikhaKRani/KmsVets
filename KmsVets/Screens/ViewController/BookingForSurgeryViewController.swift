//
//  BookingForSurgeryViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 21/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookingForSurgeryViewController: BaseViewController {
    var dateString = ""
    var nameString = ""
    var mobileString = ""
    var addressString = ""
    @IBOutlet weak var bookingSurgeryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mobileString = UserDefaults.standard.string(forKey: "mobile") ?? ""
        nameString = UserDefaults.standard.string(forKey: "name") ?? ""
        addressString = UserDefaults.standard.string(forKey: "address") ?? ""
    }
    
    
    
    @objc func saveBtnAtion() {
        
        
        var count = 0
        if nameString.isEmpty {
            count = count + 1
            self.displayMessage(message: "Please enter your full name")
            return
        }
        
        
        if addressString.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your address")
            return
        }
        if dateString.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please Choose Date")
            return
        }
        
        
        
        
        if count == 0 {
            self.confirmSurgeryBooking()
        }
    }
    
    ////MARK:- save booking for surgery api
    
    func confirmSurgeryBooking() {
        
        self.showHud("Booking in Progress")
        let params = ["key": AppConstant.UserKey, "name" : nameString, "address" : addressString , "user_id": UserDefaults.standard.string(forKey: "id") ?? "","mobile": mobileString] as Dictionary<String, String>

        
       ServiceClient.sendRequest(apiUrl: APIUrl.BOOK_SURGERY,postdatadictionary: params, isArray: false) { (response) in
           
           if let res = response as? [String : Any] {
               print(res)
            let message = res["msg"] as? String
            self.hideHUD()

            self.displayMessage(message: message)
           }
       }
    }
    
    
    @objc func tapDoneforDatePicker() {
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = bookingSurgeryTableView.cellForRow(at: indexPath) as? BookinfForSurgeryTableViewCell
  
        if let datePicker = cell?.dateTextfield.inputView as? UIDatePicker {
              
            
            let dateformatter = DateFormatter() // 2-2
//              dateformatter.dateStyle = .medium // 2-3
            dateformatter.dateFormat = "dd/MM/yyyy"
            print(dateformatter.string(from: datePicker.date))
            self.view.endEditing(true)
            //        dateSelectedFlag = "yes"
            
            
            
            cell?.dateTextfield.text = dateformatter.string(from: datePicker.date)
            dateString = dateformatter.string(from: datePicker.date)
            
          }
            cell?.dateTextfield.resignFirstResponder() // 2-5
      }
}

//MARK:- Table View Delegate
extension BookingForSurgeryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.bookingSurgeryTableView.dequeueReusableCell(withIdentifier: StringConstant.BookinfForSurgeryTableViewCell) as? BookinfForSurgeryTableViewCell
        
        cell?.nameTextfield.delegate = self
        cell?.addressTextfield.delegate = self
        cell?.mobileTextfield.delegate = self
        cell?.dateTextfield.delegate = self
        cell?.dateTextfield.setInputViewDatePicker(target: self, selector: #selector(tapDoneforDatePicker))
      


        cell?.mobileTextfield.text = mobileString
        cell?.nameTextfield.text = nameString
        cell?.addressTextfield.text = addressString
//
        cell?.mobileTextfield.isUserInteractionEnabled = false
//
//        cell?.dropDownBtn?.addTarget(self, action: #selector(dropdownAction(sender:)), for: .touchUpInside)
//
        cell?.saveButton.addTarget(self, action: #selector(saveBtnAtion), for: .touchUpInside)
//
        
        
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

extension BookingForSurgeryViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            nameString = textField.text ?? ""
        }
        else if textField.tag == 101 {
            mobileString = textField.text ?? ""
        }
        else if textField.tag == 102 {
            addressString = textField.text ?? ""
        }
        else if textField.tag == 103 {
            dateString = textField.text ?? ""
        }
        
    }
        
        
        
    }

 

