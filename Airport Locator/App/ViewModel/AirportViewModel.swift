//
//  AirportViewModel.swift
//  Airport Locator
//
//  Created by Mohd Taha on 19/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol AirportViewModelDelegate {
    func searchComplete()
}

class AirportViewModel {
    
    // MARK: - Class Variables
    private let apiHandler: APIHelper
    private(set) var airportModels: [AirportModel] = [AirportModel]()

    // MARK: - Class Initializer
    init(apiHandler: APIHelper) {
        self.apiHandler = apiHandler
    }
    
    // MARK: - Getters
    public func getName(atIndex: Int) -> String {
        return airportModels[atIndex].airportName ?? ""
    }
    
    public func getDistance(atIndex: Int) -> Double {
        let location = coordToLoc(coord: airportModels[atIndex].coordinate)
        return location.distanceFrom(location: LocationHelper.shared.getUserLocation())
    }
    
    public func getCoordinate(atIndex: Int) -> CLLocationCoordinate2D {
        return airportModels[atIndex].coordinate ?? CLLocationCoordinate2D.init()
    }
}


// MARK: - APIs
extension AirportViewModel {
    
    func populateSource(delegate: AirportViewModelDelegate, for key: String, inRegion: MKCoordinateRegion) {
        
        self.apiHandler.getSearchResult(key: key, inRegion: inRegion) { (response) in
            
            if self.airportModels.count > 0 {
                self.airportModels.removeAll()
            }
            
            for element in response {
                self.airportModels.append(AirportModel.init(mapItem: element))
            }
            
            delegate.searchComplete()
        }
    }
}

// MARK: Annotation Utils
extension AirportViewModel {
    
    // MARK: This method creates an MKPointAnnotation to plot in Map
    func getAiportAnnotation(index: Int) -> AirportAnnotation {
        
        let model = airportModels[index]
        let location = coordToLoc(coord: model.coordinate)
        let distance = location.distanceFrom(location: LocationHelper.shared.getUserLocation())
        
        return AirportAnnotation(
            name: model.airportName ?? "",
            distance: distance,
            coord: model.coordinate)
    }
}


// MARK: - Utils
extension AirportViewModel {
    
    // MARK: To conver CLLocationCoordinate2D to CLLocation
    func coordToLoc(coord: CLLocationCoordinate2D?) -> CLLocation {
        let getLat: CLLocationDegrees = coord?.latitude ?? 0.0
        let getLon: CLLocationDegrees = coord?.longitude ?? 0.0
        let newLoc: CLLocation =  CLLocation(latitude: getLat, longitude: getLon)
        return newLoc
    }
}
