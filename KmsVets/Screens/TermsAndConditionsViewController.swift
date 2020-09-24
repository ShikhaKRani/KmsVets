//
//  TermsAndConditionsViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 24/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: BaseViewController {
    @IBOutlet weak var tncTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tncTableView.separatorStyle = .none

        // Do any additional setup after loading the view.
    }
    

    
}

extension TermsAndConditionsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TnCCell") as? TnCCell
        cell?.selectionStyle = .none
        cell?.headerLbl.textColor = self.setThemeColor()
        cell?.headerLbl.font  = UIFont.systemFont(ofSize: 20)
        cell?.titleLbl.textColor = .black
        cell?.titleLbl.font  = UIFont.systemFont(ofSize: 17)
        cell?.subTitleLbl.textColor = .gray
        cell?.subTitleLbl.font  = UIFont.systemFont(ofSize: 15)
        
        
        if indexPath.row == 0 {
            cell?.headerLbl.textAlignment = .center
            cell?.headerLbl.text = StringConstant.TERMS_question1
            cell?.titleLbl.text = StringConstant.TERMS_answer1
            cell?.subTitleLbl.text = ""
        }
        else if indexPath.row == 1 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question2
            cell?.subTitleLbl.text = StringConstant.TERMS_answer2
        }
        else if indexPath.row == 2 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question3
            cell?.subTitleLbl.text = StringConstant.TERMS_answer3
        }
        else if indexPath.row == 3 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question4
            cell?.subTitleLbl.text = StringConstant.TERMS_answer4
        }
        else if indexPath.row == 4 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question5
            cell?.subTitleLbl.text = StringConstant.TERMS_answer5
        }
        else if indexPath.row == 5 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question6
            cell?.subTitleLbl.text = StringConstant.TERMS_answer6
        }
        else if indexPath.row == 6 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question7
            cell?.subTitleLbl.text = StringConstant.TERMS_answer7
        }
        else if indexPath.row == 7 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question8
            cell?.subTitleLbl.text = StringConstant.TERMS_answer8
        }
        else if indexPath.row == 8 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question9
            cell?.subTitleLbl.text = StringConstant.TERMS_answer9
        }
        else if indexPath.row == 9 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.TERMS_question10
            cell?.subTitleLbl.text = StringConstant.TERMS_answer10
        }
        
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

