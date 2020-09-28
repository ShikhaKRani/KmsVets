//
//  PlaceOrderViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 28/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class PlaceOrderViewController: UIViewController {
    
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var totalAmountLbl: UILabel!
    
    var totalAmount : Int?
    var cartItemsArray : [CartModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Place Order"
        print("total: \(totalAmount ?? 0) \n items \(cartItemsArray)" )
        self.continueBtn.addTarget(self, action: #selector(updateBtnAtion), for: .touchUpInside)
        self.totalAmountLbl.text = "\(StringConstant.RuppeeSymbol)\(totalAmount ?? 0)"
        
    }
    
    
    @objc func updateBtnAtion() {
        
        
        
    }
    
}
