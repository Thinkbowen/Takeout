//
//  DishTableViewCell.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-06.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class DishTableViewCell: UITableViewCell {

    @IBOutlet weak var dishImg: UIImageView!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishDescription: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
