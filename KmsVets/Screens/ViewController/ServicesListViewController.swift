//
//  ServicesListViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import SDWebImage


class ServicesListViewController: BaseViewController {
    @IBOutlet weak var servicelistTableView: UITableView!
    var dataArray : [[String : Any]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.servicelistTableView.tableFooterView = UIView()
        getServiceList()

        
    }
    
    func getServiceList() {
        
        self.showHud("Loading...")
        let params = ["key": AppConstant.UserKey] as Dictionary<String, String>

        
       ServiceClient.sendRequest(apiUrl: APIUrl.SERVICE_LIST,postdatadictionary: params, isArray: true) { (response) in
           
        if let res = response as? [[String : Any]] {
            if let responseLastIndex = res.last {
                if let responseArray = responseLastIndex["data"] as? [[String: Any]] {
                    print(responseArray)
                    self.dataArray = responseArray
                }
            }
            DispatchQueue.main.async { () -> Void in
            self.servicelistTableView.reloadData()
                  self.hideHUD()
            }
          
        }
       }
    }
    
    @objc func booknowbuttonAction(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let bookServiceVC = storyBoard.instantiateViewController(withIdentifier: "BookServiceViewController") as? BookServiceViewController {
            self.navigationController?.pushViewController(bookServiceVC, animated: true)
        }
        
        
    }
    

}


extension ServicesListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.servicelistTableView.dequeueReusableCell(withIdentifier: "ServiceListTableViewCell") as? ServiceListTableViewCell
        let dict = self.dataArray?[indexPath.row]
        
        cell?.titleLabel.text = dict?["title"] as? String
        let urlString = dict?["image"] as? String
        cell?.titleImage.sd_setImage(with: URL(string: urlString ?? ""), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
        
        

        cell?.booknowButton.addTarget(self, action: #selector(booknowbuttonAction), for: .touchUpInside)
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = self.dataArray?[indexPath.row]
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let service = storyBoard.instantiateViewController(withIdentifier: "ServiceDetailViewController") as? ServiceDetailViewController {
            service.dict = dict ?? [:]
            self.navigationController?.pushViewController(service, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
}
