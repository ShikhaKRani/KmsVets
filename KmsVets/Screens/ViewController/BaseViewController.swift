//
//  BaseViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 12/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import SideMenu
import Toast_Swift
import MBProgressHUD


class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
    }
    
    //MARK:- setupNavigationBar
    func setupNavigationBar() {
        // bar color
        //rgb(62,144,115)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 01/255, green: 52/255, blue: 48/255, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        //text color
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white]
        
    }
    
    func setTitleForNavigation(title : String? , isHidden : Bool) {
        self.navigationController?.isNavigationBarHidden = isHidden
        self.title = title ?? "KMS Vets"
        
    }
    
    func setThemeColor() -> UIColor {
        return UIColor(red: 01/255, green: 61/255, blue: 55/255, alpha: 1)
    }
    
    
    func displayMessage( message : String? ) {
        DispatchQueue.main.async { () -> Void in
            self.view.makeToast(message, duration: 3.0, position: .bottom)
        }
    }
    
    
    func displayAlertView (alertType: String? ,message : String ) {
        let alertController = UIAlertController(title: alertType ?? "Alert", message: message, preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
        }
        // Add the actions
        alertController.addAction(okAction)
        // Present the controller
        DispatchQueue.main.async { () -> Void in
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    
    func showHud(_ message: String) {
        DispatchQueue.main.async { () -> Void in
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        
        hud.isUserInteractionEnabled = false
        }
    }
    
    func hideHUD() {
        DispatchQueue.main.async { () -> Void in

        MBProgressHUD.hide(for: self.view, animated: true)
            
        }
    }
    
    
    func returnDateFormat(dateString : String, dateFormatInServer : String, expectedFormat : String) -> String {
        
        var  dateStr = ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = dateFormatInServer
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = expectedFormat

        if let date = dateFormatterGet.date(from: dateString) {
            print(dateFormatterPrint.string(from: date))
            dateStr = dateFormatterPrint.string(from: date)
        } else {
           print("There was an error decoding the string")
        }
        return dateStr
    }
    
    
    
//    func setUpNav() {
//        
//        let button = UIButton(type: .custom)
//        button.setBackgroundImage(UIImage(named: "cart22"), for: .normal)
//        button.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
////        button.addTarget(self, action: #selector(redirectToCart), for: .touchUpInside)
//        let barButtonItem = UIBarButtonItem(customView: button)
//
//        let button2 = UIButton(type: .custom)
//        button2.setImage(UIImage(named: "home22"), for: .normal)
//        button2.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
//        let barButtonItem2 = UIBarButtonItem(customView: button2)
//
//        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        space.width = 20
//        self.navigationItem.rightBarButtonItems = [barButtonItem,space]
//   
//    }
    
    
}

