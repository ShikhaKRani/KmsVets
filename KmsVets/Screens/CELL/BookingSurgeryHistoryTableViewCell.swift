//
//  BookingSurgeryHistoryTableViewCell.swift
//  KmsVets
//
//  Created by SUBHASH KUMAR on 22/09/20.
//  Copyright © 2020 Shikha. All rights reserved.
//

import UIKit

class BookingSurgeryHistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var currentdateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .tertiarySystemGroupedBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
