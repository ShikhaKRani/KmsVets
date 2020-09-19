//
//  BookingNewPuppyTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 18/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookingNewPuppyTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var mobileTextfield: UITextField!
    @IBOutlet weak var eamilTextfield: UITextField!
    @IBOutlet weak var addressTextfield: UITextField!
    @IBOutlet weak var petbreedTextfield: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var dropDownBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.nameTextfield.tag = 100
        self.mobileTextfield.tag = 101
        self.eamilTextfield.tag = 102
        self.addressTextfield.tag = 103
        self.petbreedTextfield.tag = 104
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
