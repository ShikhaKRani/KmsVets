//
//  ServiceDetailViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 27/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import SDWebImage

class ServiceDetailViewController: UIViewController {
    
    @IBOutlet weak var servicedetailTableView: UITableView!

    var dict : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Service Detail"
        self.servicedetailTableView.tableFooterView = UIView()
        self.servicedetailTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    @objc func booknowbuttonAction(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        if let bookServiceVC = storyBoard.instantiateViewController(withIdentifier: "BookServiceViewController") as? BookServiceViewController {
            self.navigationController?.pushViewController(bookServiceVC, animated: true)
        }
        
        
    }
    

}
extension ServiceDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.servicedetailTableView.dequeueReusableCell(withIdentifier: "detailimageCell") as? ServiceDetailTableViewCell
        
        if indexPath.section == 0 {
            let cell = self.servicedetailTableView.dequeueReusableCell(withIdentifier: "detailimageCell") as? ServiceDetailTableViewCell
            cell?.selectionStyle = .none
            let urlString  =  "\(dict["image"] ?? "")"
            cell?.titleImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
            cell?.titleLabel.text = dict["title"] as? String
            
            cell?.booknowButton.addTarget(self, action: #selector(booknowbuttonAction), for: .touchUpInside)
            return cell!
        }

        if indexPath.section == 1 {
            let cell = self.servicedetailTableView.dequeueReusableCell(withIdentifier: "descriptionCell") as? ServiceDetailTableViewCell
            cell?.descLabel.text = self.dict["description"] as? String
            
            cell?.selectionStyle = .none
            return cell!
        }
        
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    
    
}
