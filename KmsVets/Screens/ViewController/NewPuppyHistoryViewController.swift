//
//  NewPuppyHistoryViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 18/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class NewPuppyHistoryViewController: BaseViewController {
    @IBOutlet weak var newppuppyHistoryTableView: UITableView!

    var dataArray : [[String : Any]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.newppuppyHistoryTableView.tableFooterView = UIView()
        self.getNewPuppyList()
        newppuppyHistoryTableView.backgroundColor = .clear
        self.view.backgroundColor = .groupTableViewBackground
        self.title = "Pet History"

    }
    
    
    //MARK:- getNewPuppyList
     func getNewPuppyList() {
         
         self.showHud("Loading...")
         let params = ["key": AppConstant.UserKey, "user_id": UserDefaults.standard.string(forKey: "id") ?? ""] as Dictionary<String, String>

         
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_NEW_PUPPY,postdatadictionary: params, isArray: false) { (response) in
            
            if let res = response as? [String : Any] {
                self.dataArray = res["data"] as? [[String: Any]] ?? [[:]]
                DispatchQueue.main.async { () -> Void in
                self.newppuppyHistoryTableView.reloadData()
                      self.hideHUD()
                }
              
            }
        }
     }
    
    

}




extension NewPuppyHistoryViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.newppuppyHistoryTableView.dequeueReusableCell(withIdentifier: StringConstant.NewPuppyHistoryTableViewCell) as? NewPuppyHistoryTableViewCell
        let dict = self.dataArray?[indexPath.row]
        
        cell?.nameLabel.text = dict?["name"] as? String
        cell?.mobileLabel.text = dict?["mobile"] as? String
        cell?.emailLabel.text = dict?["email"] as? String
        cell?.addressLabel.text = dict?["address"] as? String
        cell?.breedLabel.text = dict?["breed"] as? String
        cell?.descLabel.text = dict?["description"] as? String
        cell?.currentdateLabel.text = dict?["cdate"] as? String

        
        
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
