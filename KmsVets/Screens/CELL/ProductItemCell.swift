//
//  ProductItemCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 28/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ProductItemCell: UITableViewCell {
        
        @IBOutlet weak var titleLbl: UILabel!
        @IBOutlet weak var discountLbl: UILabel!
        @IBOutlet weak var oldPriceLbl: UILabel!
        @IBOutlet weak var currentPriceLbl: UILabel!
        @IBOutlet weak var addButton: UIButton!
        @IBOutlet weak var minusButton: UIButton!
        @IBOutlet weak var itemCountLbl: UILabel!
        @IBOutlet weak var addInitialButton: UIButton!
        @IBOutlet weak var titleImg: UIImageView!
        @IBOutlet weak var trailingConstraintForInitialAddbutton: NSLayoutConstraint!

    @IBOutlet weak var deleteItemBtn: UIButton!
    @IBOutlet weak var weightLbl: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
