//
//  BookingSurgeryHistoryViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 22/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookingSurgeryHistoryViewController: BaseViewController {
    @IBOutlet weak var bookingSurgeryHistoryTableView: UITableView!
    var dataArray : [[String : Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bookingSurgeryHistoryTableView.tableFooterView = UIView()
        self.getSurgeryHistoryList()
        bookingSurgeryHistoryTableView.backgroundColor = .clear
        self.view.backgroundColor = .tertiarySystemGroupedBackground
        self.bookingSurgeryHistoryTableView.separatorStyle = .none

        // Do any additional setup after loading the view.
    }
    
    func getSurgeryHistoryList() {
        
        self.showHud("Loading...")
        let params = ["key": AppConstant.UserKey, "user_id": UserDefaults.standard.string(forKey: "id") ?? ""] as Dictionary<String, String>

        
       ServiceClient.sendRequest(apiUrl: APIUrl.BOOK_SURGERY_HISTORY,postdatadictionary: params, isArray: false) { (response) in
           
           if let res = response as? [String : Any] {
               self.dataArray = res["data"] as? [[String: Any]] ?? [[:]]
               DispatchQueue.main.async { () -> Void in
               self.bookingSurgeryHistoryTableView.reloadData()
                     self.hideHUD()
               }
             
           }
       }
    }
    

}

extension BookingSurgeryHistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.bookingSurgeryHistoryTableView.dequeueReusableCell(withIdentifier: StringConstant.BookingSurgeryHistoryTableViewCell) as? BookingSurgeryHistoryTableViewCell
        let dict = self.dataArray?[indexPath.row]
        
        cell?.nameLabel.text = dict?["name"] as? String
        cell?.mobileLabel.text = dict?["mobile"] as? String
        cell?.addressLabel.text = dict?["address"] as? String
        cell?.currentdateLabel.text = dict?["date"] as? String

        
        
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
