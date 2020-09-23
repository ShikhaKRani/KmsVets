//
//  SuggestionTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 23/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class SuggestionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var mobileField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.nameField.tag = 100
//        self.commentTextView.tag = 1000
//        self.mobileField.tag = 101
//        self.submitButton.tag = 102
        
//        nameField.layer.cornerRadius = 5
//        nameField.layer.borderColor = UIColor.green.cgColor
//        nameField.layer.borderWidth = 1
//
//        mobileField.layer.cornerRadius = 5
//        mobileField.layer.borderColor = UIColor.green.cgColor
//        mobileField.layer.borderWidth = 1
//
//        commentTextView.layer.cornerRadius = 5
//        commentTextView.layer.borderColor = UIColor.green.cgColor
//        commentTextView.layer.borderWidth = 1
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
