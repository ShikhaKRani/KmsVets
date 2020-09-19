//
//  ProfileViewTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 18/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProfileViewTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userMobile: UITextField!
    @IBOutlet weak var userAddress: UITextField!
    @IBOutlet weak var userZipcode: UITextField!
    @IBOutlet weak var userCity: UITextField!
    @IBOutlet weak var profileupdateButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.image = UIImage(named: "medicine.jpeg")
        userImage?.layer.cornerRadius = (userImage?.frame.size.width ?? 0.0) / 2
        userImage?.clipsToBounds = true
        userImage?.layer.borderWidth = 3.0
        userImage?.layer.borderColor = UIColor.white.cgColor
        
        self.fullName.tag = 100
        self.userName.tag = 101
        self.userEmail.tag = 102
        self.userMobile.tag = 103
        self.userAddress.tag = 104
        self.userZipcode.tag = 105
        self.userCity.tag = 106
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
