//
//  CustomerBasicInfoViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 14/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CustomerBasicInfoViewController: BaseViewController {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    
    @IBOutlet weak var infoTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        setTitleForNavigation(title: "KMS Vets", isHidden: false)
        
        infoTableView.tableFooterView = UIView()
        infoTableView.separatorStyle = .none
        
        
    }
    
    
    @objc func redirectToHomeInfoScreen(sender : UIButton) {
        
        let storyBoard = UIStoryboard.init(name: "SideMenu", bundle: nil)
        if let homeinfoViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            
            let navController = UINavigationController.init(rootViewController: homeinfoViewController)
            self.appDelegate?.window?.rootViewController = navController

            
        }
  
        
    }
    
    
}

extension CustomerBasicInfoViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.infoTableView.dequeueReusableCell(withIdentifier: StringConstant.CustomerInformationCell) as? CustomerInformationCell
        
        cell?.continueButton.addTarget(self, action: #selector(redirectToHomeInfoScreen(sender:)), for: .touchUpInside)
        cell?.customerName.text = "SUbhash"
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
