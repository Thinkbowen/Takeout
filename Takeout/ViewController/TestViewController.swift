//
//  TestViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-03.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var FirstHeroName: UILabel!
    var heroes = [HeroStats2]()
    var firstHeroName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getName {
            self.FirstHeroName.text = self.firstHeroName
        }
        getJSON {
            self.tabelView.reloadData()
            print("Successful")
        }
        tabelView.delegate = self
        tabelView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        let cell = UITableViewCell(style: .default, reuseIdentifier:nil)
        cell.textLabel?.text = heroes[indexPath.row].localized_name.capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroViewController {
            destination.hero = heroes[(tabelView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func getName(completed:@escaping () -> ()) {
        RestAPIManager.sharedInstance.getTodo(id: 1, onSuccess:{
            (todo: Todo) in print(todo.title!)
            self.firstHeroName = todo.title
            DispatchQueue.main.sync {
                completed()
            }
        }, onFailure: {_ in
            DispatchQueue.main.sync {
                print("getName Failed")
            }
        })
    }
    func getJSON(completed:@escaping () -> ()) {
        RestAPIManager.sharedInstance.getHeros( onSuccess:{
            (heroes: [HeroStats2]) in print("Successful")
            self.heroes = heroes
            DispatchQueue.main.sync {
                completed()
            }
        }, onFailure: {_ in
            DispatchQueue.main.sync {
                print("getName Failed")
            }
        })
    }
}
