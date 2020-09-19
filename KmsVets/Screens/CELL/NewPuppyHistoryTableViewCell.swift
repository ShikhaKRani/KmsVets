//
//  NewPuppyHistoryTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 18/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class NewPuppyHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var customerName: UITextField!
       @IBOutlet weak var customerEmail: UITextField!
       @IBOutlet weak var customerAddress: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
