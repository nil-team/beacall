//
//  ViewController.swift
//  beacall
//
//  Created by nil-team on 20/12/2017.
//  Copyright © 2017 nil-team. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import QuartzCore

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    let mainLocation = CLLocation(latitude: 48.869139, longitude: 2.341399)
    let regionRadius: CLLocationDistance = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // Annotation : Palais Brogniart
        let annotBrogniart: MKPointAnnotation = MKPointAnnotation()
        annotBrogniart.coordinate = CLLocationCoordinate2DMake(48.869139, 2.341399);
        annotBrogniart.title = "Palais Brongniart"
        
        // Annotation : Les Panoramas
        let annotPanoramas: MKPointAnnotation = MKPointAnnotation()
        annotPanoramas.coordinate = CLLocationCoordinate2DMake(48.870558, 2.342297);
        annotPanoramas.title = "Les Panoramas"
        
        mapView?.delegate = self
        mapView?.userTrackingMode = .follow
        mapView?.addAnnotation(annotBrogniart)
        mapView?.addAnnotation(annotPanoramas)
        
        zoomToRegion(location: mainLocation)
        
        let mainRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 48.86915, longitude: 2.341407), radius: 30, identifier: "palais")
        let circle = MKCircle(center: mainRegion.center, radius: mainRegion.radius)
        
        let mainRegion2 = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 48.870558, longitude: 2.342297), radius: 30, identifier: "palais")
        let circle2 = MKCircle(center: mainRegion2.center, radius: mainRegion2.radius)
        
        mapView.add(circle2)
        mapView.add(circle)
        
        locationManager.startMonitoring(for: mainRegion)
        locationManager.startUpdatingLocation()
        
        // Beacons
        let region = CLBeaconRegion(proximityUUID: UUID(uuidString:"f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "uBeacon")
        let region2 = CLBeaconRegion(proximityUUID: UUID(uuidString:"e16e8a8e-34ec-4326-b21e-9b35f22f405b")!, identifier: "uBeacon2")
        let region3 = CLBeaconRegion(proximityUUID: UUID(uuidString:"f2a74fc4-7625-44db-9b08-cb7e130b2029")!, identifier: "uBeacon3")
        
        locationManager.startRangingBeacons(in: region)
        locationManager.startRangingBeacons(in: region2)
        locationManager.startRangingBeacons(in: region3)
        
    }
    
    func zoomToRegion(location: CLLocation){
        let coordinateRegion =
            MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.2)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.lineWidth = 1
        return circleRenderer
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region.identifier == "brognart" {
            let region = CLBeaconRegion(proximityUUID: UUID(uuidString:"f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "uBeacon")
            let region2 = CLBeaconRegion(proximityUUID: UUID(uuidString:"e16e8a8e-34ec-4326-b21e-9b35f22f405b")!, identifier: "uBeacon2")
            let region3 = CLBeaconRegion(proximityUUID: UUID(uuidString:"f2a74fc4-7625-44db-9b08-cb7e130b2029")!, identifier: "uBeacon3")
            
            locationManager.startMonitoring(for: region)
            locationManager.startMonitoring(for: region2)
            locationManager.startMonitoring(for: region3)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region.identifier == "brognart" {
            for ranging in locationManager.rangedRegions {
                if let beacon = ranging as? CLBeaconRegion {
                    locationManager.stopRangingBeacons(in: beacon)
                }
            }
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        for b in beacons {
            // Checker if user.cours.time = place.cours.time
            var prox = "Unknown"
            switch b.proximity {
            case .near:
                prox = "We are close by"
            case .immediate:
                prox = "We are close by"
            default:
                prox = "We are not close"
            }
            print("Beacon \(b.minor) : \(prox)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

