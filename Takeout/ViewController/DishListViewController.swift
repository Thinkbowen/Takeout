//
//  DishListViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-06.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class DishListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var dishTableView: UITableView!
    @IBOutlet weak var chefView: UIView!
    @IBOutlet weak var chefImg: UIImageView!
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefPrice: UILabel!
    @IBOutlet weak var chefOrderCount: UILabel!
    @IBOutlet weak var chefDistance: UILabel!
    
    var chef: Chef?
    var menus: [Menu]? //Used when we have multiple menus...
    var menu: Menu? //For now, just assume there's only one menu for each chef
    var dish = Dish()

    override func viewDidLoad() {
        super.viewDidLoad()
        chefName.text = chef?.name
        chefPrice.text = "\((chef?.paymentRatio)!)"
        chefDistance.text = "\((chef?.distance)!)" + " Km"
        dishTableView.delegate = self
        dishTableView.dataSource = self
    }
    
    func EmptyCart() {
        let messageLabel = UILabel(frame:CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height:  self.view.bounds.size.height))
        chefView.isHidden = true
        messageLabel.text = "Menu Is Empty"
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        self.dishTableView.backgroundView = messageLabel
        self.dishTableView.backgroundView?.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.dishTableView.separatorStyle = .none;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if ((menus?.count)! == 0) {
            EmptyCart()
        } else {
            chefView.isHidden = false
        }
        return (menus?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus![section].dishs!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dishTableCell") as! DishTableViewCell
        
        let menuSection = menus![indexPath.section]
        let dishs = menuSection.dishs
        let dish = dishs![indexPath.row]
        
        // Of course, need to change this later....
        cell.dishDescription.text = dish.description
        cell.dishName.text = dish.name
        cell.dishPrice.text = "\((dish.price))"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuSection = menus![indexPath.section]
        let dishs = menuSection.dishs!
        dish = dishs[indexPath.row]
        performSegue(withIdentifier: "showDish", sender: self)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("MenuHeaderTableViewCell", owner: self, options: nil)?.first as? MenuHeaderTableViewCell
        headerView?.menuTitle.text = menus![section].name
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(44)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DishViewController {
            print(dish)
            let chefDish = ChefDish(chef: chef!, dish: dish)
            destination.chefDish = chefDish
        }
    }
}
