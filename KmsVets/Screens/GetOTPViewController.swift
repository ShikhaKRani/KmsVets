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
        
        doneButton.addTarget(self, action: #selector(redirectToCustomerInfoScreen), for: .touchUpInside)

        self.getOtpApiCall()
        
    }
    
    @objc func redirectToCustomerInfoScreen(sender : UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let customerinfoViewController = storyBoard.instantiateViewController(withIdentifier: "CustomerBasicInfoViewController") as? CustomerBasicInfoViewController {
            
            
           
            self.navigationController?.pushViewController(customerinfoViewController, animated: true)
        }
    }
    

    func getOtpApiCall() {
        
        
        let parameters = [
            "order_id": "102"
        ]
        
        AF.request(APIUrl.ORDER_DETAILS, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    

}

extension NSAttributedString
{
    convenience init(text: String, aligment: NSTextAlignment, color:UIColor) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle, NSAttributedString.Key.foregroundColor:color])
    }
}

extension GetOTPViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
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
