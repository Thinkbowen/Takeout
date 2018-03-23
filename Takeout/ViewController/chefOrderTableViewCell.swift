//
//  chefOrderTableViewCell.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-19.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class chefOrderTableViewCell: UITableViewCell {
  //MARK: Properties
  @IBOutlet weak var dishName: UILabel!
  @IBOutlet weak var quantity: UILabel!
  @IBOutlet weak var orderTime: UILabel!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var deliverBtn: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
