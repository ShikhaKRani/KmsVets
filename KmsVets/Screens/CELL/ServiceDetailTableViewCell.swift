//
//  ServiceDetailTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 27/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ServiceDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var booknowButton: UIButton!
    @IBOutlet weak var descLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
