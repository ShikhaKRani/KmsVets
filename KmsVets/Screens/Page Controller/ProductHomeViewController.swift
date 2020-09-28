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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationHomeIdentifier"), object: nil)

        self.viewCartButton.addTarget(self, action: #selector(redirectToCart), for: .touchUpInside)
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
    @objc func redirectToCart() {
        
        let storyBoard = UIStoryboard.init(name: "ProductHome", bundle: nil)
        if let cartVC = storyBoard.instantiateViewController(withIdentifier: "ProductCartViewController") as? ProductCartViewController {
            
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    
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
