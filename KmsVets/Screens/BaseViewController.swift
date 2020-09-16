//
//  BaseViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 12/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

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
    
    

}

