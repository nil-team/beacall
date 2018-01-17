//
//  ViewController.swift
//  beacall
//
//  Created by Arnaud Manaranche on 20/12/2017.
//  Copyright © 2017 ArnaudManaranche. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import QuartzCore

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView?.showsUserLocation = true

        mapView?.showsCompass = true
        mapView?.showsScale = true
        
        let eemi = Annotation(title: "Ecole Européenne des Métiers de l'Internet",
                       locationName: "EEMI",
                       discipline: "School",
                       coordinate: CLLocationCoordinate2D(latitude: 48.8688356, longitude: 2.3414426))
        mapView?.addAnnotation(eemi)
        
        let panos = Annotation(title: "Panoramas",
                        locationName: "Les Panoramas",
                        discipline: "Hub",
                        coordinate: CLLocationCoordinate2D(latitude: 48.870537, longitude: 2.342358))
        mapView?.addAnnotation(panos)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location:CLLocation = locations[0]
        
        let latitudeUtilisateur = location.coordinate.latitude
        let longitudeUtilisateur = location.coordinate.longitude
        
        let latDelta:CLLocationDegrees = 0.01
        let lngDelta:CLLocationDegrees = 0.01
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitudeUtilisateur, longitudeUtilisateur)
        
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)
        
        
        mapView?.setRegion(region, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

