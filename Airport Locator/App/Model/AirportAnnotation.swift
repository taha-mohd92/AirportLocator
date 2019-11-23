//
//  AirportAnnotation.swift
//  Airport Locator
//
//  Created by Mohd Taha on 21/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit
import MapKit

class AirportAnnotation: MKPointAnnotation {
    
    init(name: String, distance: Double?, coord: CLLocationCoordinate2D?) {
        super.init()
        
        self.title = name
        self.subtitle = "\(distance ?? 0) km"
        self.coordinate = coord ?? CLLocationCoordinate2D()
    }
}
