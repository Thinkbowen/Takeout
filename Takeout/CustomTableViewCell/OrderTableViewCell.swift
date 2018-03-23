//
//  OrderTableViewCell.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-07.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

protocol OrderCellDelegate {
    func removeDishClick(chefDish: ChefDish)
}

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderView: UIView!
    @IBOutlet weak var dishName: UILabel!
    @IBOutlet weak var dishImg: UIImageView!
    @IBOutlet weak var dishDescription: UILabel!
    @IBOutlet weak var dishPrice: UILabel!
    
    var dish: Dish?
    var chefDish: ChefDish?
    var delegate:OrderCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func removeDishBtnClick(_ sender: UIButton) {
        delegate?.removeDishClick(chefDish: chefDish!)
    }
}
