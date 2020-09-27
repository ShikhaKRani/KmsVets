//
//  ProdcutListViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProdcutListViewController: BaseViewController {
    
    
    @IBOutlet weak var itemTableView: UITableView!
    
    var categoryDict : [String : Any]?
    var productItemArray : [[String: Any]]?
    
    var indexSelected : String?
    
    class func create() -> ProdcutListViewController {
        let mainStoryboard = UIStoryboard(name: "ProductHome", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: String(describing: self)) as! ProdcutListViewController
        
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableView.rowHeight = UITableView.automaticDimension
        itemTableView.estimatedRowHeight = 100
        itemTableView.tableFooterView = UIView()
        
        if let array = productItemArray {
            productItemArray = array
            itemTableView.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)

    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        print(notification.userInfo)
    }

    
    
}


//MARK:- Delegate and Datasource

extension ProdcutListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productItemArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
        
        let dict = self.productItemArray?[indexPath.row]
        cell.titleLbl?.text = dict?["title"] as? String
        let urlString  =  "\(AppURL.ICON_URL)\(dict?["image"] ?? "")"
        cell.titleImg.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
    
        
        let discountData = dict?["discounts"] as? [[String: Any]]
        if let lastItem = discountData?.last {
            
            cell.discountLbl?.text = lastItem["discount"] as? String
            cell.oldPriceLbl?.text = lastItem["market_price"] as? String
            cell.currentPriceLbl?.text = lastItem["sale_price"] as? String
            
            let cartquantity = lastItem["cartquantity"] as? String
            var quantity : Int?
            
            if ((cartquantity?.isEmpty) == nil) {
                quantity = Int(cartquantity ?? "0")
            }else{
                quantity = Int(cartquantity ?? "0")
                
            }
            
            cell.itemCountLbl.text = "\(quantity ?? 0)"
            print("\(String(describing: quantity))")
            
            if quantity == 0 {
                cell.addButton.isHidden = true
                cell.minusButton.isHidden = true
                cell.itemCountLbl.isHidden = true
                
                cell.addInitialButton.isHidden = false
                cell.trailingConstraintForInitialAddbutton.constant = 10
            }else{
                cell.addButton.isHidden = false
                cell.minusButton.isHidden = false
                cell.itemCountLbl.isHidden = false
                cell.addInitialButton.isHidden = true
                
                cell.trailingConstraintForInitialAddbutton.constant = 110
            }
            
        }
        
       
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


//MARK:- Cell
class ProductItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var oldPriceLbl: UILabel!
    @IBOutlet weak var currentPriceLbl: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var itemCountLbl: UILabel!
    @IBOutlet weak var addInitialButton: UIButton!

    @IBOutlet weak var titleImg: UIImageView!

    @IBOutlet weak var trailingConstraintForInitialAddbutton: NSLayoutConstraint!
}


