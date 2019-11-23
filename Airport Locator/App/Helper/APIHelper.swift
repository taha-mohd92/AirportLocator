//
//  APIHelper.swift
//  Airport Locator
//
//  Created by Mohd Taha on 22/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit
import MapKit

class APIHelper: NSObject {
    
    private static var instance: APIHelper?
    
    override init() {}
    
    func getSearchResult(key: String, inRegion: MKCoordinateRegion, completion: @escaping (([MKMapItem?]) -> Void)) {
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = key
        request.region = inRegion
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            
            guard let response = response else { return }
            completion(response.mapItems)
        }
    }
}
