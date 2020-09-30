//
//  BookServiceTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 30/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookServiceTableViewCell: UITableViewCell {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var petnameField: UITextField!
    @IBOutlet weak var petbreedField: UITextField!
    @IBOutlet weak var petbreedButton: UIButton!
    @IBOutlet weak var petbreedImage: UIImageView!
    @IBOutlet weak var petageyearField: UITextField!
    @IBOutlet weak var peageyearButton: UIButton!
    @IBOutlet weak var petaggeyearImage: UIImageView!
    @IBOutlet weak var petagemonthField: UITextField!
    @IBOutlet weak var peagemonthButton: UIButton!
    @IBOutlet weak var petagemonthImage: UIImageView!
    @IBOutlet weak var registrationField: UITextField!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var registrationImage: UIImageView!
    @IBOutlet weak var petregistrationField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var msgLbl: UILabel!

    @IBOutlet weak var verticalSpaceFornextBtn: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
