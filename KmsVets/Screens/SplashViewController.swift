//
//  SplashViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 12/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    @IBOutlet weak var medicineImageView: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleForNavigation(title: "KMS Vets", isHidden: false)
        
        self.loginBtn.backgroundColor = self.setThemeColor()
        
        self.medicineImageView.layer.masksToBounds = true
        self.medicineImageView.layer.cornerRadius = 20

        
        self.loginBtn.layer.cornerRadius = 10
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.addTarget(self, action: #selector(redirectToLoginScreen(sender:)), for: .touchUpInside)
    }
    

    

    
    @objc func redirectToLoginScreen(sender : UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
           
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
}
