//
//  FAQViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 24/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class FAQViewController: BaseViewController {

    @IBOutlet weak var faqTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.faqTableView.separatorStyle = .none
        
        
        
    }

}

extension FAQViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FAQCell") as? FAQCell
        cell?.selectionStyle = .none
        cell?.headerLbl.textColor = self.setThemeColor()
        cell?.headerLbl.font  = UIFont.systemFont(ofSize: 20)
        cell?.titleLbl.textColor = .black
        cell?.titleLbl.font  = UIFont.systemFont(ofSize: 17)
        cell?.subTitleLbl.textColor = .gray
        cell?.subTitleLbl.font  = UIFont.systemFont(ofSize: 15)
        
        
        if indexPath.row == 0 {
            cell?.headerLbl.text = "FAQ"
            cell?.titleLbl.text = ""
            cell?.subTitleLbl.text = StringConstant.FAQ
        }
        else if indexPath.row == 1 {
            cell?.headerLbl.text = "GENERAL QUESTIONS"
            cell?.titleLbl.text = StringConstant.FAQ_question1
            cell?.subTitleLbl.text = StringConstant.FAQ_answer1
        }
        else if indexPath.row == 2 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question2
            cell?.subTitleLbl.text = StringConstant.FAQ_answer2
        }
        else if indexPath.row == 3 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question3
            cell?.subTitleLbl.text = StringConstant.FAQ_answer3
        }
        else if indexPath.row == 4 {
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question4
            cell?.subTitleLbl.text = StringConstant.FAQ_answer4
        }
        else if indexPath.row == 5{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question5
            cell?.subTitleLbl.text = StringConstant.FAQ_answer5
        }
        else if indexPath.row == 6{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question6
            cell?.subTitleLbl.text = StringConstant.FAQ_answer6
        }
        else if indexPath.row == 7{
            cell?.headerLbl.text = "MEDICINE QUESTIONS"
            cell?.titleLbl.text = StringConstant.FAQ_question7
            cell?.subTitleLbl.text = StringConstant.FAQ_answer7
        }
        else if indexPath.row == 8{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question8
            cell?.subTitleLbl.text = StringConstant.FAQ_answer8
        }
        else if indexPath.row == 9{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question9
            cell?.subTitleLbl.text = StringConstant.FAQ_answer9
        }
        else if indexPath.row == 10{
            cell?.headerLbl.text = "DELIVERY QUESTIONS"
            cell?.titleLbl.text = StringConstant.FAQ_question10
            cell?.subTitleLbl.text = StringConstant.FAQ_answer10
        }
        else if indexPath.row == 11{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question11
            cell?.subTitleLbl.text = StringConstant.FAQ_answer11
        }
        else if indexPath.row == 12{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question12
            cell?.subTitleLbl.text = StringConstant.FAQ_answer12
        }
        else if indexPath.row == 13{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question13
            cell?.subTitleLbl.text = StringConstant.FAQ_answer13
        }
        else if indexPath.row == 14{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question14
            cell?.subTitleLbl.text = StringConstant.FAQ_answer14
        }
        else if indexPath.row == 15{
            cell?.headerLbl.text = ""
            cell?.titleLbl.text = StringConstant.FAQ_question15
            cell?.subTitleLbl.text = StringConstant.FAQ_answer15
        }
        
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
