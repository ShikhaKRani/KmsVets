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
    
    var productModelArray = [ProductInfo]()

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
       
//        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    
//    @objc func methodOfReceivedNotification(notification: Notification) {
//        print(notification.userInfo)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let array = productItemArray {
            productItemArray = array
            
            productModelArray.removeAll()
            for item in array {
                let model = ProductInfo(dict: item)
                productModelArray.append(model)
            }
            itemTableView.reloadData()
            
        }
    }
    
    @objc func addBtnAction(sender : UIButton) {
        
        let cell = sender.superview?.superview as? ProductItemCell
        let indexPath = itemTableView.indexPath(for: cell!)
        let model = self.productModelArray[indexPath?.row ?? 0]
        
        var count = model.quantityForCartItem ?? 0
        count = count + 1

        if count == 0 {
            cell?.addButton.isHidden = true
            cell?.minusButton.isHidden = true
            cell?.itemCountLbl.isHidden = true
            
            cell?.addInitialButton.isHidden = false
            cell?.trailingConstraintForInitialAddbutton.constant = 10
        }else{
            cell?.addButton.isHidden = false
            cell?.minusButton.isHidden = false
            cell?.itemCountLbl.isHidden = false
            cell?.addInitialButton.isHidden = true
            
            cell?.trailingConstraintForInitialAddbutton.constant = 110
        }
        
        
        model.quantityForCartItem =  count
        
    // api call
        cell?.itemCountLbl.text = "\(model.quantityForCartItem ?? 0)"
        model.quantity = model.quantityForCartItem
        self.addProductToCart(model: model, tag: sender.tag)

    }
    
    @objc func minusBtnAction(sender : UIButton) {
        
        let cell = sender.superview?.superview as? ProductItemCell
        let indexPath = itemTableView.indexPath(for: cell!)
        let model = self.productModelArray[indexPath?.row ?? 0]
        
        var count = model.quantityForCartItem ?? 0
        
        if count == 0 {
            cell?.addButton.isHidden = true
            cell?.minusButton.isHidden = true
            cell?.itemCountLbl.isHidden = true
            
            cell?.addInitialButton.isHidden = false
            cell?.trailingConstraintForInitialAddbutton.constant = 10
        }else{
            cell?.addButton.isHidden = false
            cell?.minusButton.isHidden = false
            cell?.itemCountLbl.isHidden = false
            cell?.addInitialButton.isHidden = true
            cell?.trailingConstraintForInitialAddbutton.constant = 110
        }
        
        
        if count > 1 {
            count = count - 1
            model.quantityForCartItem =  count
            
            cell?.itemCountLbl.text = "\(model.quantityForCartItem ?? 0)"
            model.quantityForCartItem = count
            model.quantity = model.quantityForCartItem
            self.addProductToCart(model: model,tag: sender.tag)
        }
        
       
        
        
    }
    
    
    func addProductToCart(model : ProductInfo!, tag : Int) {
    
        self.showHud("")
        let product_id = model.id ?? ""
        let dis_id = model.dis_id ?? ""
        let quantityForCartItem = "\(model.quantityForCartItem ?? 0)"

        
        ServiceClient.sendRequest(apiUrl: APIUrl.ADD_CART,postdatadictionary: ["userId": UserDefaults.standard.string(forKey: "id") ?? "", "cartquantity" : quantityForCartItem, "id" : product_id, "discount_id" : dis_id ], isArray: false) { (response) in

            if let res = response as? [String : Any] {
                print(res)
                
                
                DispatchQueue.main.async { () -> Void in
                    let indexPath = IndexPath(item: tag, section: 0)
                    self.itemTableView.reloadRows(at: [indexPath], with: .none)

                }
                

                NotificationCenter.default.post(name: Notification.Name("NotificationHomeIdentifier"), object: nil, userInfo: ["response":"\(res)"])

                self.hideHUD()
            }
       }
    }
    
    
}


//MARK:- Delegate and Datasource

extension ProdcutListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productItemArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
        cell.selectionStyle = .none
        let model = self.productModelArray[indexPath.row]
        
        cell.titleLbl?.text = model.title
        cell.weightLbl.text = "Weight:\(model.gmqty ?? "")\(model.unit ?? "")"
        let urlString  =  "\(AppURL.ICON_URL)\(model.image ?? "")"
        cell.titleImg.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
        
        cell.addButton.addTarget(self, action: #selector(addBtnAction(sender:)), for: .touchUpInside)
        cell.minusButton.tag = indexPath.row
        cell.addButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(minusBtnAction(sender:)), for: .touchUpInside)
        cell.addInitialButton.addTarget(self, action: #selector(addBtnAction(sender:)), for: .touchUpInside)
                
        cell.discountLbl?.text = model.discount
        cell.oldPriceLbl?.text = "\(StringConstant.RuppeeSymbol)\(model.market_price ?? "0")"
        cell.oldPriceLbl?.textColor = .red
        cell.currentPriceLbl?.text = "\(StringConstant.RuppeeSymbol)\(model.sale_price ?? "0")"
        let cartquantity = model.quantity
        if model.quantityForCartItem ?? 0 == 0 {
            model.quantityForCartItem = cartquantity
        }
       
        if model.quantityForCartItem ?? 0 > 0 {
            cell.itemCountLbl.text = "\(model.quantityForCartItem ?? 0)"
        }else{
            cell.itemCountLbl.text = "\(cartquantity ?? 0)"

        }
        
        print("\(String(describing: cartquantity))")
        
        if cartquantity == 0 {
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}


