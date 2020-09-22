//
//  AppExtension.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 22/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import Foundation
import UIKit


extension UITextField {
    
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker: UIDatePicker = {
               let dp = UIDatePicker()
//               dp.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
               return dp
           }()
        
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
//    @objc private func datePickerValueChanged(datePicker: UIDatePicker) {
////            textField.text = dateFormatter.string(from: datePicker.date)
//
//    }
    
    
}


