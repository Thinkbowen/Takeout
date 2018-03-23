//
//  chefMenuViewController.swift
//  takeoutfood
//
//  Created by Fred Chen on 2018-01-15.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class chefMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  //MARK: Properties
  @IBOutlet weak var dishTableView: UITableView!
  var menus: [Menu]?
  var dish = Dish()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.loadDish()
    
  }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

      func EmptyCart() {
        let messageLabel = UILabel(frame:CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height:  self.view.bounds.size.height))
        //chefView.isHidden = true
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
        print(menus)
        if ((menus?.count)! == 0) {
            EmptyCart()
        } else {
            //chefView.isHidden = false
        }
        return (menus?.count)!
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus![section].dishs!.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "chefMenuTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? chefMenuTableViewCell  else {
    fatalError("The dequeued cell is not an instance of chefMenuTableViewCell.")
        // Fetches the appropriate meal for the data source layout.
        }
        let menuSection = menus![indexPath.section]
        let dishs = menuSection.dishs
        let dish = dishs![indexPath.row]

        cell.nameLabel.text = dish.name
        cell.priceLabel.text = "\((dish.price))"
        return cell
}
  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Private Methods
 
    private func loadDish() {
        RestAPIManager.sharedInstance.get_menus(id:ChefManager.sharedInstance.chef._id,
            onSuccess:{
                (wholemenu:[Menu]) in DispatchQueue.main.sync{
                print("get menu success")
                self.menus = wholemenu
                  print(wholemenu)
                  self.dishTableView.reloadData()
                  self.dishTableView.delegate = self
                  self.dishTableView.dataSource = self
                }
            }, onFailure: {
                _ in DispatchQueue.main.sync{
                    print("get chef menu fail")
                }
            })
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuSection = menus![indexPath.section]
        let dishs = menuSection.dishs!
        dish = dishs[indexPath.row]
        performSegue(withIdentifier: "chefEditDish", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? chefEditDishViewController {
            print(dish)
            //let dish = self.dish
            destination.oldDish = dish
        }
    }

}
