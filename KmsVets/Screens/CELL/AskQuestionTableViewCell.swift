//
//  AskQuestionTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 25/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class AskQuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var mobileField: UITextField!
    @IBOutlet weak var quesTextview: UITextView!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var numberofQuestionField: UITextField!
    @IBOutlet weak var submitButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
