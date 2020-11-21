//
//  SplashViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 12/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    @IBOutlet weak var medicineImageView: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleForNavigation(title: "KMS Vets", isHidden: false)
        
        self.loginBtn.backgroundColor = self.setThemeColor()
        
        self.medicineImageView.layer.masksToBounds = true
        self.medicineImageView.layer.cornerRadius = 20
        
        self.loginBtn.layer.cornerRadius = 10
        self.loginBtn.layer.masksToBounds = true
        self.loginBtn.addTarget(self, action: #selector(redirectToLoginScreen(sender:)), for: .touchUpInside)
        
        self.skipBtn.addTarget(self, action: #selector(skipAction(sender:)), for: .touchUpInside)
        self.skipBtn.backgroundColor = self.setThemeColor()
        self.skipBtn.layer.cornerRadius = 10
        self.skipBtn.layer.masksToBounds = true
    }
    
    @objc func skipAction(sender : UIButton) {
    
        let storyBoard = UIStoryboard.init(name: "SideMenu", bundle: nil)
        if let homeinfoViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            
            
            UserDefaults.standard.set("189", forKey: "userId")
            UserDefaults.standard.set("", forKey: "mobile")
            UserDefaults.standard.set("Guest", forKey: "username")
            UserDefaults.standard.set("", forKey: "address")
            UserDefaults.standard.set("Guest", forKey: "name")
            UserDefaults.standard.set("", forKey: "email")
            
            
            let navController = UINavigationController.init(rootViewController: homeinfoViewController)
            self.appDelegate?.window?.rootViewController = navController

            
        }
        
    }
    
    @objc func redirectToLoginScreen(sender : UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let loginViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
           
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    
    //chart
    @objc func redirectToChartScreen(sender : UIButton) {
           
           let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
           if let chartVC = storyBoard.instantiateViewController(withIdentifier: "MyChartViewController") as? MyChartViewController {
              
               self.navigationController?.pushViewController(chartVC, animated: true)
           }
       }
}
