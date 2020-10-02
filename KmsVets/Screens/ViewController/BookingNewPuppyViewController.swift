//
//  BookingNewPuppyViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 18/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import DropDown
import Alamofire



class BookingNewPuppyViewController: BaseViewController {
    
    @IBOutlet weak var bookingnewppuppyTableView: UITableView!
    

    var mobile = ""
    var descriptionStr = ""
    var name = ""
    var email = ""
    var address = ""
    
    
    
    let dropDown = DropDown();
    var petsBreed = ""
    var petArray : [[String: Any]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPetList()
        
        mobile = UserDefaults.standard.string(forKey: "mobile") ?? ""
        email = UserDefaults.standard.string(forKey: "email") ?? ""

        name = UserDefaults.standard.string(forKey: "name") ?? ""

        address = UserDefaults.standard.string(forKey: "address") ?? ""
        self.title = "Booking Pet"

        
    }
    
    @objc func saveBtnAtion() {
        
        
        var count = 0
        if name.isEmpty {
            count = count + 1
            self.displayMessage(message: "Please enter your full name")
            return
        }
        
        if email.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your email")
            return
        }
        
        if address.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter your address")
            return
        }
        
        if petsBreed.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please select pet breed")
            return
        }
        if descriptionStr.isEmpty {
            
            count = count + 1
            self.displayMessage(message: "Please enter description")
            return
        }
        
        if count == 0 {
            self.confirmBookingPuppy()
        }
    }
    
    ////MARK:- save booking new puppy api
    
    func confirmBookingPuppy() {
        
        self.showHud("Booking in Progress")
        let params = ["key": AppConstant.UserKey, "name" : name, "email" : email, "address" : address , "user_id": UserDefaults.standard.string(forKey: "id") ?? "","breed": petsBreed, "description" : descriptionStr ,"mobile": mobile] as Dictionary<String, String>

        
       ServiceClient.sendRequest(apiUrl: APIUrl.BOOK_NEW_PUPPY,postdatadictionary: params, isArray: false) { (response) in
           
           if let res = response as? [String : Any] {
               print(res)
            let message = res["msg"] as? String
            self.hideHUD()

            self.displayMessage(message: message)
           }
       }
    }
    

    //MARK:- fetchPetList
    func fetchPetList() {
        //params
        let params = ["key": AppConstant.UserKey] as Dictionary<String, String>
        self.showHud("Loading...")

        var request = URLRequest(url: URL(string: APIUrl.GET_PET_LIST)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
       
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! [[String : Any]]
                let dict = json[0]
                let dataArray = dict["data"]
                self.petArray = dataArray as! [[String : Any]]
                self.hideHUD()

            } catch {
                print(" Parshing Error")
            }
        })
        
        task.resume()
    }
    
    
    //Button Action
    
    @objc func dropdownAction (sender : UIButton) {
        guard let cell = sender.superview?.superview as? BookingNewPuppyTableViewCell else {
            return
        }
       
        var petList = [String]()
        for petDict in self.petArray {
            let pet_name = petDict["pet_name"] as? String
            petList.append(pet_name?.capitalized ?? "")
        }
        
        print(petList)
        
        self.dropDown.anchorView = cell.petbreedTextfield.plainView
        self.dropDown.bottomOffset = CGPoint(x: 0, y: (sender).bounds.height)
        self.dropDown.dataSource.removeAll()
        self.dropDown.dataSource = petList
        self.dropDown.selectionAction = { [unowned self] (index, item) in
            
            print(item)
            cell.petbreedTextfield.text = item
            self.petsBreed = item
        }
        self.dropDown.show()
    }
    

}

//MARK:-  Textfield Delegate

extension BookingNewPuppyViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 100 {
            name = textField.text ?? ""
        }
        else if textField.tag == 101 {
            mobile = textField.text ?? ""
        }
        else if textField.tag == 102 {
            email = textField.text ?? ""
        }
        else if textField.tag == 103 {
            address = textField.text ?? ""
        }
        else if textField.tag == 104 {
            petsBreed = textField.text ?? ""
        }
        
        
    }
}
 





//MARK:-  TextView Delegate
extension BookingNewPuppyViewController : UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.tag == 1000 {
            textView.text  = ""
            textView.textColor = UIColor.black
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.tag == 1000 {
            descriptionStr = textView.text
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


//MARK:- Table View Delegate
extension BookingNewPuppyViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.bookingnewppuppyTableView.dequeueReusableCell(withIdentifier: StringConstant.BookingNewPuppyTableViewCell) as? BookingNewPuppyTableViewCell
        
        cell?.nameTextfield.delegate = self
        cell?.eamilTextfield.delegate = self
        cell?.addressTextfield.delegate = self
        cell?.mobileTextfield.delegate = self
       
        cell?.descriptionTextView.delegate = self
        cell?.descriptionTextView.tag = 1000

        cell?.descriptionTextView.text = "Type Dog description you will buy"
        cell?.descriptionTextView.textColor = UIColor.lightGray
        cell?.descriptionTextView.layer.borderWidth = 0.4
        cell?.descriptionTextView.layer.borderColor = UIColor.darkGray.cgColor
        cell?.descriptionTextView.layer.cornerRadius = 10.0

        cell?.mobileTextfield.text = mobile
        cell?.nameTextfield.text = name
        cell?.eamilTextfield.text = email
        cell?.addressTextfield.text = address
        
        cell?.mobileTextfield.isUserInteractionEnabled = false

        cell?.dropDownBtn?.addTarget(self, action: #selector(dropdownAction(sender:)), for: .touchUpInside)

        cell?.saveButton.addTarget(self, action: #selector(saveBtnAtion), for: .touchUpInside)
        
        
        
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
