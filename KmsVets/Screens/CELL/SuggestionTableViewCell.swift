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
        
//        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
