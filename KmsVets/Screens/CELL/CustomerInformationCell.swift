//
//  CustomerInformationCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 14/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class CustomerInformationCell: UITableViewCell {

    @IBOutlet weak var customerName: UITextField!
    @IBOutlet weak var customerEmail: UITextField!
    @IBOutlet weak var customerAddress: UITextField!
    @IBOutlet weak var continueButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
