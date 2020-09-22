//
//  BookinfForSurgeryTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 21/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookinfForSurgeryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var mobileTextfield: UITextField!
    @IBOutlet weak var addressTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameTextfield.tag = 100
        self.mobileTextfield.tag = 101
        self.addressTextfield.tag = 102
        self.dateTextfield.tag = 103
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
