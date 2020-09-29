//
//  ProductHomeViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit
import Segmentio



class ProductHomeViewController: BaseViewController {
    
    fileprivate var currentStyle = SegmentioStyle.onlyLabel
    fileprivate var containerViewController: EmbedContainerViewController?
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var viewCartButton: UIButton!

    var cartItemsArray = [CartModel]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Products"
        
        self.getCartDetails()
        self.setUpNav()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationHomeIdentifier"), object: nil)

        self.viewCartButton.addTarget(self, action: #selector(redirectToCart), for: .touchUpInside)
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

        let button2 = UIButton(type: .custom)
        button2.setImage(UIImage(named: "search"), for: .normal)
        button2.frame = CGRect(x: 0.0, y: 0.0, width: 25, height: 25)
        button2.addTarget(self, action: #selector(redirectToSearchScreen), for: .touchUpInside)

        let barButtonItemright = UIBarButtonItem(customView: button2)

        let space2 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space2.width = 20
        self.navigationItem.rightBarButtonItems = [barButtonItem,space2,barButtonItemright]
   
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
                            
                            
                            
                        },
                        {_ in
                            print("cancel click")
                        }
                       ])
        
    }
    
    
    @objc func redirectToCart() {
        
        let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
        if let cartVC = storyBoard.instantiateViewController(withIdentifier: "ProductCartViewController") as? ProductCartViewController {
            
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
    @objc func redirectToSearchScreen() {
        
        let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
        if let searchVC = storyBoard.instantiateViewController(withIdentifier: "SearchProductViewController") as? SearchProductViewController {
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: EmbedContainerViewController.self) {
            containerViewController = segue.destination as? EmbedContainerViewController
            containerViewController?.style = currentStyle
        }
    }
}

extension ProductHomeViewController {
   
    
    @objc func methodOfReceivedNotification(notification: Notification) {        
        self.getCartDetails()
    }
        
   // calling API
    func getCartDetails() {
        
        var costOfItem = 0
        var itemsSelected = 0
        
        var totalPrice = 0
        var totalItem = 0


        ServiceClient.sendRequest(apiUrl: APIUrl.GET_CART,postdatadictionary: ["userId" : UserDefaults.standard.string(forKey: "id") ?? ""], isArray: false) { (response) in

            if let res = response as? [String : Any] {

                print(res)
                if let dataArray = res["data"] as? [[String: Any]] {
                    for itemDict in dataArray {
                        
                        let cartModel = CartModel(dict: itemDict)
                        self.cartItemsArray.append(cartModel)
                        
                        costOfItem = Int(cartModel.sale_price ?? "0") ?? 0
                        itemsSelected = Int(cartModel.cartquantity ?? "0") ?? 0
                        let finalPricePerItem = costOfItem * itemsSelected
                        
                        totalPrice =  totalPrice + finalPricePerItem
                        totalItem = totalItem + itemsSelected
                    }
                }
                
                DispatchQueue.main.async { () -> Void in
                    self.totalPriceLabel.text = "\(totalItem) Items ₹ \(totalPrice)"
                }
            }
       }
    }
}
