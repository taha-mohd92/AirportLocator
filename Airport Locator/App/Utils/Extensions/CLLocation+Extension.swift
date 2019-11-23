//
//  CLLocation+Extension.swift
//  Airport Locator
//
//  Created by Mohd Taha on 21/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit
import CoreLocation

extension CLLocation {
    
    // MARK: Method to calculte disatnce in KM
    func distanceFrom(location: CLLocation) -> Double {
        return location.distance(from: self).convertToKM()
    }
}

extension Double {
    
    // MARK: This method converts distance in meters to KM
    func convertToKM() -> Double {
        return (self/1000.0 * 100).rounded()/100
    }
}
