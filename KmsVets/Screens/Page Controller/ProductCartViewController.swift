//
//  ProductCartViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 28/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProductCartViewController: BaseViewController {
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var deliveryChargeLbl: UILabel!
    @IBOutlet weak var grandTotalLbl: UILabel!
    @IBOutlet weak var checkOutBtn: UIButton!

    var cartItemsArray = [CartModel]()
    var totalPrice = 0
    var deliveryTotalPrice = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgImgView.isHidden = true

        cartTableView.tableFooterView = UIView()
        self.title = "View Cart"
        self.navigationItem.hidesBackButton = true
 
        let trash_button = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(rightBarButtonAction))
        navigationItem.rightBarButtonItems = [trash_button]
        
        let homebutton = UIButton(type: .custom)
        homebutton.setImage(UIImage(named: "home22"), for: .normal)
        homebutton.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        homebutton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let barButtonItem2 = UIBarButtonItem(customView: homebutton)

        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 20
        self.navigationItem.leftBarButtonItems = [barButtonItem2,space]
        
        self.checkOutBtn.addTarget(self, action: #selector(redirectToNextScreen), for: .touchUpInside)
    }
    
    
    @objc func redirectToNextScreen() {

        if self.cartItemsArray.count > 0 {
            let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
            if let addressVc = storyBoard.instantiateViewController(withIdentifier: "ConfirmAddressViewController") as? ConfirmAddressViewController {
                
                addressVc.cartItemsArray = self.cartItemsArray
                addressVc.totalAmount = self.totalPrice

                self.navigationController?.pushViewController(addressVc, animated: true)
            }
        }else{
            self.displayAlertView(alertType: "Alert", message: "Your Cart is empty. Please add items in your cart.")
        }
        
    }
    
    @objc func backAction() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    @objc func rightBarButtonAction() {
        
        self.openAlert(title: "Alert",
                       message: "Are you sure you want to remove items from Cart?",
                       alertStyle: .alert,
                       actionTitles: ["Okay", "Cancel"],
                       actionStyles: [.default, .cancel],
                       actions: [
                        {_ in
                            print("okay click")
                            self.clearCart()
                        },
                        {_ in
                            print("cancel click")
                        }
                       ])
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCartDetails()
        
    }
    
    
    @objc func addBtnAction(sender : UIButton) {
        
        let cell = sender.superview?.superview as? ProductItemCell
        let indexPath = cartTableView.indexPath(for: cell!)
        let model = self.cartItemsArray[indexPath?.row ?? 0]
        
        var count = model.quantityForCartItem ?? 0
        count = count + 1
        model.quantityForCartItem =  count
        
        // api call
        cell?.itemCountLbl.text = "\(model.quantityForCartItem ?? 0)"
        model.quantity = model.quantityForCartItem
        self.addProductToCart(model: model, tag: sender.tag)
        
    }
    
    @objc func minusBtnAction(sender : UIButton) {
        
        let cell = sender.superview?.superview as? ProductItemCell
        let indexPath = cartTableView.indexPath(for: cell!)
        let model = self.cartItemsArray[indexPath?.row ?? 0]
        
        var count = model.quantityForCartItem ?? 0
        if count > 1 {
            count = count - 1
            model.quantityForCartItem =  count
            
            cell?.itemCountLbl.text = "\(model.quantityForCartItem ?? 0)"
            model.quantityForCartItem = count
            
            model.quantity = model.quantityForCartItem
            self.addProductToCart(model: model,tag: sender.tag)
        }
        else{
            //delete
            model.quantityForCartItem = 0
            model.isDELETE = true
            self.addProductToCart(model: model,tag: sender.tag)
        }
        
        
        
    }
    
    
    
    @objc func deleteBtnAction(sender : UIButton) {
        
        let cell = sender.superview?.superview as? ProductItemCell
        let indexPath = cartTableView.indexPath(for: cell!)
        let model = self.cartItemsArray[indexPath?.row ?? 0]
        model.quantityForCartItem = 0
        model.isDELETE = true
        self.addProductToCart(model: model,tag: sender.tag)
        
    }
    
    
    
    func addProductToCart(model : CartModel!, tag : Int) {
        
        self.showHud("")
        let product_id = model.id ?? ""
        let dis_id = model.dis_id ?? ""
        let quantityForCartItem = "\(model.quantityForCartItem ?? 0)"
        self.bgImgView.isHidden = true
        
        ServiceClient.sendRequest(apiUrl: APIUrl.ADD_CART,postdatadictionary: ["userId": UserDefaults.standard.string(forKey: "id") ?? "", "cartquantity" : quantityForCartItem, "id" : product_id, "discount_id" : dis_id ], isArray: false) { (response) in
            
            if let res = response as? [String : Any] {
                print(res)
                
                if model.isDELETE ?? false {
                    self.fetchCartDetails()
                }
                else {
                    DispatchQueue.main.async { () -> Void in
                        let indexPath = IndexPath(item: tag, section: 0)
                        self.cartTableView.reloadRows(at: [indexPath], with: .none)
                        
                    }
                }
                
                
                
                self.hideHUD()
            }
        }
    }
    
    
    //MARK:- calling API
    func fetchCartDetails() {
        
        var costOfItem = 0
        var itemsSelected = 0        
        var totalItem = 0
        
        DispatchQueue.main.async { () -> Void in
        self.bgImgView.isHidden = true
            self.showHud("")
        }
        ServiceClient.sendRequest(apiUrl: APIUrl.GET_CART,postdatadictionary: ["userId" : UserDefaults.standard.string(forKey: "id") ?? ""], isArray: false) { (response) in
            
            if let res = response as? [String : Any] {
                
                print(res)
                if let dataArray = res["data"] as? [[String: Any]] {
                    self.cartItemsArray.removeAll()
                    for itemDict in dataArray {
                        let cartModel = CartModel(dict: itemDict)
                        self.cartItemsArray.append(cartModel)
                        
                        costOfItem = Int(cartModel.sale_price ?? "0") ?? 0
                        itemsSelected = Int(cartModel.cartquantity ?? "0") ?? 0
                        let finalPricePerItem = costOfItem * itemsSelected
                        self.totalPrice =  self.totalPrice + finalPricePerItem
                        totalItem = totalItem + itemsSelected
                        let charge = Int(cartModel.deliverycharge ?? "0") ?? 0
                        
                        self.deliveryTotalPrice = self.deliveryTotalPrice + charge
                    }
                }
                else{
                    self.cartItemsArray = []
                }
                
                DispatchQueue.main.async { () -> Void in
                    self.cartTableView.reloadData()
                    if self.cartItemsArray.count > 0 {
                        self.bgImgView.isHidden = true

                    }else{
                        self.bgImgView.isHidden = false

                    }

                    self.totalLbl.text = "Total Price: \(StringConstant.RuppeeSymbol)\(self.totalPrice)"
                    self.deliveryChargeLbl.text = "Delivery Charge: \(StringConstant.RuppeeSymbol)\(self.deliveryTotalPrice)"
                    self.grandTotalLbl.text = "Grand Total: \(StringConstant.RuppeeSymbol)\(self.totalPrice + self.deliveryTotalPrice)"

                    
                    self.hideHUD()
                }
            }
        }
    }
    
    
    //MARK:- calling API
    func clearCart() {
        
        self.showHud("")
        ServiceClient.sendRequest(apiUrl: APIUrl.DELET_ALL_CART,postdatadictionary: ["userId" : UserDefaults.standard.string(forKey: "id") ?? ""], isArray: false) { (response) in
            
            if let res = response as? [String : Any] {
                print(res)
                self.hideHUD()
                self.cartItemsArray = []                
                DispatchQueue.main.async { () -> Void in
                    self.cartTableView.reloadData()
                    self.totalLbl.text = "Total Price: \(StringConstant.RuppeeSymbol)\("0")"
                    self.deliveryChargeLbl.text = "Delivery Charge: \(StringConstant.RuppeeSymbol)\("0")"
                    self.grandTotalLbl.text = "Grand Total: \(StringConstant.RuppeeSymbol)\("0")"
                    self.bgImgView.isHidden = false

                }
            }
        }
    }
    
    
    
}


extension ProductCartViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.cartItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemCell", for: indexPath) as! ProductItemCell
        cell.selectionStyle = .none
        let model = self.cartItemsArray[indexPath.row]
        
        cell.titleLbl?.text = model.title
        cell.weightLbl.text = "Weight:\(model.gmqty ?? "")\(model.unit ?? "")"
        let urlString  =  "\(AppURL.ICON_URL)\(model.image ?? "")"
        cell.titleImg.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "medicine.jpeg") ,options: .refreshCached, completed: nil)
        
        cell.addButton.addTarget(self, action: #selector(addBtnAction(sender:)), for: .touchUpInside)
        cell.minusButton.tag = indexPath.row
        cell.addButton.tag = indexPath.row
        cell.minusButton.addTarget(self, action: #selector(minusBtnAction(sender:)), for: .touchUpInside)
        
        cell.deleteItemBtn.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)
        cell.deleteItemBtn.tag = indexPath.row
        
        
        
        cell.discountLbl?.text = "\(model.discount ?? "")% off"
        cell.oldPriceLbl?.textColor = .red
        cell.currentPriceLbl?.text = "\(StringConstant.RuppeeSymbol)\(model.sale_price ?? "0")"
        
        AppClass.strikeOnlabel(yourText: "\(StringConstant.RuppeeSymbol)\(model.market_price ?? "0")", yourLabel: cell.oldPriceLbl)

        
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
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
