//
//  OrderPaymentInfoTableViewCell.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-14.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class OrderPaymentInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var grandTotal: UILabel!
    @IBOutlet weak var paymentMethod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
