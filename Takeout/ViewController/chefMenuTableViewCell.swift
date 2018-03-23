//
//  chefMenuTableViewCell.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-17.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class chefMenuTableViewCell: UITableViewCell {
  //MARK: Properties
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
