//
//  MapViewController.swift
//  takeoutfood
//
//  Created by Jennifer Wu on 2018-01-10.
//  Copyright © 2018 fred. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let manager = CLLocationManager()
    var chefLocations = [Location]()
    var selectedLocation = MKPointAnnotation()
    var useSelectedLocation = false;
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0] //Most recent location of the user
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        if(!useSelectedLocation) {
            selectedLocation.coordinate.latitude = location.coordinate.latitude
            selectedLocation.coordinate.longitude = location.coordinate.longitude
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        mapView.isZoomEnabled = true
        //Delete this when API is good to go
        initChefLocation();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func resetLocation(_ sender: UIButton) {
        self.mapView.removeAnnotations(self.mapView.annotations)
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    @IBAction func chefNearByBtnClicked(_ sender: UIButton) {
        //        RestAPIManager.sharedInstance.get_chefs(type: <#T##String#>, limit: <#T##Int#>, longitude: <#T##Float#>, latitude: <#T##Float#>, onSuccess: <#T##([Chef]) -> Void#>, onFailure: <#T##(Any) -> Void#>)
        for location in chefLocations {
            let annotation = MKPointAnnotation()
            let coordinate = CLLocationCoordinate2DMake(location.latitude,location.longitude)
            annotation.coordinate = coordinate
            annotation.title = "Chef Name"
            annotation.subtitle = location.address
            self.mapView.addAnnotation(annotation)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    @IBAction func addPin(_ sender: UILongPressGestureRecognizer) {
        useSelectedLocation = true
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        mapView.removeAnnotations(mapView.annotations)
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "Selected Location"
        annotation.subtitle = "latitude:" + "\((coordinate.latitude))" + ", longitude:" +  "\((coordinate.longitude))"
        mapView.addAnnotation(annotation)
    }
    
    func initChefLocation() {
        let loc1 = Location(address:"66 Bridgeport Rd E", latitude:43.469047, longitude:-80.516228)
        let loc2 = Location(address: "44 Laurel St", latitude: 43.467513, longitude: -80.517649)
        let loc3 = Location(address:"Brighton Yards Driveway", latitude: 43.468999, longitude: -80.519379)
        chefLocations.append(loc1)
        chefLocations.append(loc2)
        chefLocations.append(loc3)
    }
    @IBAction func searchLocation(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion:nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide Search Bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil {
                print("ERROR")
            } else {
                // Remove annotations
                self.mapView.removeAnnotations(self.mapView.annotations)
                // Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in an annotaion
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpanMake(0.01, 0.01)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
        }
        
    }
}

