//
//  RecentCurrencyRateTableViewCell.swift
//  Forex
//
//  Created by Lynn Phay U on 1/10/19.
//  Copyright © 2019 Lynn Phay U. All rights reserved.
//

import UIKit

class RecentCurrencyRateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var buy: UILabel!
    @IBOutlet weak var sell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
