//
//  Annotation.swift
//  beacall
//
//  Created by Arnaud Manaranche on 10/01/2018.
//  Copyright © 2018 ArnaudManaranche. All rights reserved.
//

import MapKit

class Annotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
