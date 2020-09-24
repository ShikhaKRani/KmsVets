//
//  PrivacyPolicyViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 24/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: BaseViewController {
    @IBOutlet weak var privacyTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.privacyTableView.separatorStyle = .none

        // Do any additional setup after loading the view.
    }
    

}

extension PrivacyPolicyViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyPolicyCell") as? PrivacyPolicyCell
        cell?.selectionStyle = .none
        cell?.headerLbl.textColor = self.setThemeColor()
        cell?.headerLbl.font  = UIFont.systemFont(ofSize: 20)
        cell?.titleLbl.textColor = .black
        cell?.titleLbl.font  = UIFont.systemFont(ofSize: 17)
        cell?.subTitleLbl.textColor = .gray
        cell?.subTitleLbl.font  = UIFont.systemFont(ofSize: 15)
        
        
        if indexPath.row == 0 {
            cell?.headerLbl.text = StringConstant.PRIVACY_question1
            cell?.titleLbl.text = StringConstant.PRIVACY_answer1
            cell?.subTitleLbl.text = ""
        }
        else if indexPath.row == 1 {
            cell?.headerLbl.text = StringConstant.PRIVACY_question2
            cell?.titleLbl.text = StringConstant.PRIVACY_answer2
            cell?.subTitleLbl.text = ""
        }
        else if indexPath.row == 2 {
            cell?.headerLbl.text = StringConstant.PRIVACY_question3
            cell?.titleLbl.text = StringConstant.PRIVACY_answer3
            cell?.subTitleLbl.text = ""
        }
        else if indexPath.row == 3 {
            cell?.headerLbl.text = StringConstant.PRIVACY_question4
            cell?.titleLbl.text = StringConstant.PRIVACY_answer4
            cell?.subTitleLbl.text = ""
        }
        
        
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
