//
//  ProductDetailViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 29/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Alamofire

class ProductDetailCell : UITableViewCell {
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var oldPriceLbl: UILabel!
    @IBOutlet weak var newPriceLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var minusBtn: UIButton!
    @IBOutlet weak var addFBtn: UIButton!
    @IBOutlet weak var weightLbl: UILabel!

    @IBOutlet weak var trailingConstraintForInitialAddbutton: NSLayoutConstraint!

}

class ProductDetailViewController: BaseViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var totalDataLbl: UILabel!
    @IBOutlet weak var viewCartbtn: UIButton!
    
    var productInfo: ProductInfo?

    var detailModel: ProductInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNav()
        self.totalDataLbl.textColor = .white
        viewCartbtn.addTarget(self, action: #selector(redirectToCart), for: .touchUpInside)
    }
 
    func setUpNav() {
        
        let homebutton = UIButton(type: .custom)
        homebutton.setImage(UIImage(named: "home22"), for: .normal)
        homebutton.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        homebutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let barButtonItem2 = UIBarButtonItem(customView: homebutton)

        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 20
        self.navigationItem.leftBarButtonItems = [barButtonItem2,space]

        
        //right nav
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "cart22"), for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        button.addTarget(self, action: #selector(redirectToCart), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)

        let space2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space2.width = 20
        self.navigationItem.rightBarButtonItems = [barButtonItem,space2]
   
    }
    
    
    @objc func backAction() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func redirectToCart() {
        
        let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
        if let cartVC = storyBoard.instantiateViewController(withIdentifier: "ProductCartViewController") as? ProductCartViewController {
            
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let model = productInfo {
            detailModel = model
            let sale = Int(detailModel?.sale_price ?? "0") ?? 0
            let count = detailModel?.quantity  ?? 0
            let total =  count * sale
            self.totalDataLbl.text = "\(detailModel?.quantity ?? 0) Items \(StringConstant.RuppeeSymbol)\(total)"
        }
        

        
        
    }
    

    @objc func addBtnAction(sender : UIButton) {

        let cell = sender.superview?.superview as? ProductDetailCell
        let model = self.detailModel

        var count = model?.quantityForCartItem ?? 0
        count = count + 1
        if count == 0 {
            cell?.plusBtn.isHidden = true
            cell?.minusBtn.isHidden = true
            cell?.countLbl.isHidden = true

            cell?.addFBtn.isHidden = false
            cell?.trailingConstraintForInitialAddbutton.constant = 10
        }else{
            cell?.plusBtn.isHidden = false
            cell?.minusBtn.isHidden = false
            cell?.countLbl.isHidden = false
            cell?.addFBtn.isHidden = true

            cell?.trailingConstraintForInitialAddbutton.constant = 110
        }
        model?.quantityForCartItem =  count

    // api call
        model?.quantity = model?.quantityForCartItem
        cell?.countLbl.text = "\(model?.quantityForCartItem ?? 0)"

        self.addProductToCart(model: model, tag: sender.tag)

    }
    
    @objc func minusBtnAction(sender : UIButton) {

        let cell = sender.superview?.superview as? ProductDetailCell
        let model = self.detailModel

        var count = model?.quantityForCartItem ?? 0
        if count == 0 {
            cell?.plusBtn.isHidden = true
            cell?.minusBtn.isHidden = true
            cell?.countLbl.isHidden = true

            cell?.addFBtn.isHidden = false
            cell?.trailingConstraintForInitialAddbutton.constant = 10
        }else{
            cell?.plusBtn.isHidden = false
            cell?.minusBtn.isHidden = false
            cell?.countLbl.isHidden = false
            cell?.addFBtn.isHidden = true
            cell?.trailingConstraintForInitialAddbutton.constant = 110
        }

        if count > 1 {
            count = count - 1
            model?.quantityForCartItem =  count
            cell?.countLbl.text = "\(model?.quantityForCartItem ?? 0)"
            model?.quantityForCartItem = count
            model?.quantity = model?.quantityForCartItem
            self.addProductToCart(model: model,tag: sender.tag)
        }else{
            count = 0
            model?.quantityForCartItem =  count
            cell?.countLbl.text = "\(model?.quantityForCartItem ?? 0)"
            model?.quantityForCartItem = count
            model?.quantity = model?.quantityForCartItem
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
                    self.tblView.reloadRows(at: [indexPath], with: .none)
                    let sale = Int(model.sale_price ?? "0") ?? 0
                    let count = model.quantity ?? 0
                    let total =  count * sale
                    
                    self.totalDataLbl.text = "\(model.quantity ?? 0) Items \(StringConstant.RuppeeSymbol)\(total)"

                }


                NotificationCenter.default.post(name: Notification.Name("NotificationHomeIdentifier"), object: nil, userInfo: ["response":"\(res)"])

                self.hideHUD()
            }
       }
    }
    

}


extension ProductDetailViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblView.dequeueReusableCell(withIdentifier: "titleCell") as? ProductDetailCell
        
        cell?.titleLbl.text = "Description"
        cell?.subTitleLbl.textColor = .black

        cell?.subTitleLbl.text = detailModel?.descriptionPR
        cell?.subTitleLbl.textColor = .gray

        
        if indexPath.section == 0 {
            let cell = self.tblView.dequeueReusableCell(withIdentifier: "detailCell") as? ProductDetailCell

            cell?.titleLbl.text = detailModel?.title
            cell?.discountLbl.text = "  \(detailModel?.discount ?? "")% off  "
            cell?.oldPriceLbl.textColor = .red
            cell?.newPriceLbl.text = "\(StringConstant.RuppeeSymbol)\(detailModel?.sale_price ?? "")"
            cell?.weightLbl.text = "Weight : \(detailModel?.gmqty ?? "")\(detailModel?.unit ?? "")"
            
            AppClass.strikeOnlabel(yourText: "\(StringConstant.RuppeeSymbol)\(detailModel?.market_price ?? "")", yourLabel: (cell?.oldPriceLbl)!)
            
            cell?.minusBtn.addTarget(self, action: #selector(minusBtnAction(sender:)), for: .touchUpInside)
            cell?.plusBtn.addTarget(self, action: #selector(addBtnAction(sender:)), for: .touchUpInside)
            cell?.addFBtn.addTarget(self, action: #selector(addBtnAction(sender:)), for: .touchUpInside)
            
            let urlString  =  "\(AppURL.ICON_URL)\(detailModel?.image ?? "")"
            cell?.logoImgView.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)

            
            let cartquantity = detailModel?.quantity
            if detailModel?.quantityForCartItem ?? 0 == 0 {
                detailModel?.quantityForCartItem = cartquantity
            }
           
            if detailModel?.quantityForCartItem ?? 0 > 0 {
                cell?.countLbl.text = "\(detailModel?.quantityForCartItem ?? 0)"
            }else{
                cell?.countLbl.text = "\(cartquantity ?? 0)"

            }
            
            print("\(String(describing: cartquantity))")
            
            if cartquantity == 0 {
                cell?.plusBtn.isHidden = true
                cell?.minusBtn.isHidden = true
                cell?.countLbl.isHidden = true
                
                cell?.addFBtn.isHidden = false
                cell?.trailingConstraintForInitialAddbutton.constant = 10
            }else{
                cell?.plusBtn.isHidden = false
                cell?.minusBtn.isHidden = false
                cell?.countLbl.isHidden = false
                cell?.addFBtn.isHidden = true
                
                cell?.trailingConstraintForInitialAddbutton.constant = 110
            }
            
            return cell!

        }
        return cell!
        //detailCell  titleCell
    }
    
    
}
