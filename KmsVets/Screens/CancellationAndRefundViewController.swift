//
//  CancellationAndRefundViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 24/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CancellationAndRefundViewController: BaseViewController {
    @IBOutlet weak var cancelTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancelTableView.separatorStyle = .none

        // Do any additional setup after loading the view.
    }
    

    

}

extension CancellationAndRefundViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CancellationCell") as? CancellationCell
        cell?.selectionStyle = .none
        cell?.headerLbl.textColor = self.setThemeColor()
        cell?.headerLbl.font  = UIFont.systemFont(ofSize: 20)
        cell?.titleLbl.textColor = .black
        cell?.titleLbl.font  = UIFont.systemFont(ofSize: 17)
        cell?.subTitleLbl.textColor = .gray
        cell?.subTitleLbl.font  = UIFont.systemFont(ofSize: 15)
        
        
        if indexPath.row == 0 {
            cell?.headerLbl.textAlignment = .center
            cell?.headerLbl.text = StringConstant.CANCEL_question1
            cell?.titleLbl.text = StringConstant.CANCEL_answer1
            cell?.subTitleLbl.text = ""
        }
       
        
        
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
