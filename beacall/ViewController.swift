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

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let brognart = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 48.869404, longitude: 2.341428), radius: 10, identifier: "brognart")

        locationManager.startMonitoring(for: brognart)
        
//        let region = CLBeaconRegion(proximityUUID: UUID(uuidString:"f7826da6-4fa2-4e98-8024-bc5b71e0893e")!, identifier: "uBeacon")
//        let region2 = CLBeaconRegion(proximityUUID: UUID(uuidString:"e16e8a8e-34ec-4326-b21e-9b35f22f405b")!, identifier: "uBeacon2")
//        let region3 = CLBeaconRegion(proximityUUID: UUID(uuidString:"f2a74fc4-7625-44db-9b08-cb7e130b2029")!, identifier: "uBeacon3")
//
//        locationManager.startRangingBeacons(in: region)
//        locationManager.startRangingBeacons(in: region2)
//        locationManager.startRangingBeacons(in: region3)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region.identifier == "brognart" {
            let y = "test"
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
    
}

