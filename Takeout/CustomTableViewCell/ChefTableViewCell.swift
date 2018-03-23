//
//  Chef2TableViewCell.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-06.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class ChefTableViewCell: UITableViewCell {
    @IBOutlet weak var chefImg: UIImageView!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefPrice: UILabel!
    @IBOutlet weak var chefDistance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
