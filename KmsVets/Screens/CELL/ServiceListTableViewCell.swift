//
//  ServiceListTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 26/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class ServiceListTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var booknowButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
