//
//  TransactionSuccessViewController.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 26/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class TransactionSuccessViewController: UIViewController {

    var screen : String?
    var order_id : String?
    
    
    var totalPriceAmount : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---->>>>>>>>>>> screen : \(screen ?? "") order_id = \(order_id ?? "0")")
    }

}
