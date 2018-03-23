//
//  OrderChefInfoTableViewCell.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-14.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class OrderChefInfoTableViewCell: UITableViewCell, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefMap: MKMapView!
    @IBOutlet weak var chefLocation: UILabel!
    let manager = CLLocationManager()
    var chef = OrderManager.sharedInstance.newOrderDisplay.chef
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        chef = OrderManager.sharedInstance.newOrderDisplay.chef
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        chefMap.isZoomEnabled = true
        
        chefMap!.showsPointsOfInterest = true
        if let chefMap = self.chefMap {
            chefMap.delegate = self
        }
        initLocation()
        
    }
    
    func initLocation() {
        guard chef.location?.address != "" else {
            return
        }
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2DMake((chef.location?.latitude)!, (chef.location?.longitude)!)
//        let coordinate = CLLocationCoordinate2DMake(43.477120999999997, -80.537167999999994)
        annotation.coordinate = coordinate
        annotation.title =  chef.name
        annotation.subtitle = chef.location?.address
        chefMap.addAnnotation(annotation)
      self.chefMap?.setRegion(MKCoordinateRegionMakeWithDistance(coordinate, 500, 500), animated: true)
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
