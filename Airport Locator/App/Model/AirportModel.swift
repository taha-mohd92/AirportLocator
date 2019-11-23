//
//  AirportModel.swift
//  Airport Locator
//
//  Created by Mohd Taha on 22/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AirportModel {

    var airportName : String? = nil
    var coordinate  : CLLocationCoordinate2D? = nil
    
    init(mapItem: MKMapItem?) {
        self.airportName = mapItem?.name ?? ""
        self.coordinate  = mapItem?.placemark.coordinate ?? CLLocationCoordinate2D()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
