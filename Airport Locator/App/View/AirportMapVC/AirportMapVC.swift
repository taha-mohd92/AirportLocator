//
//  AirportMapVC.swift
//  Airport Locator
//
//  Created by Mohd Taha on 19/11/2019.
//  Copyright © 2019 Mohd Taha. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AirportMapVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Class Variables
    var mapView : MKMapView!
    var airportViewModel: AirportViewModel = AirportViewModel(apiHandler: APIHelper.init())

    
    // MARK: - Class Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func onClickRightButtonItem() {
        setRightButtonLoader()
        airportViewModel.populateSource(
            delegate: self,
            for: GlobalConstants.airportKey,
            inRegion: mapView.region)
    }
    
    func setupUI() {
        setPageTitle("Airport Locator")
        setRightButtonItem(type: .refresh)
        initMapView()
    }
    
    func initMapView() {
        mapView = MKMapView(frame: containerView.frame)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        containerView.addSubview(mapView)
        
        fetchUserLocation()
    }
    
    
    // MARK: - IBActions
    @IBAction func onClickMyLocationButton(_ sender: Any) {
        centerMapOnLocation(location: LocationHelper.shared.getUserLocation())
    }
}


// MARK: - Extension: Map Functions
extension AirportMapVC {
    
    // MARK: This method fetches the user location, also helps to enable location services
    func fetchUserLocation() {
        
        if LocationHelper.shared.isLocationServiceEnabled() {
            
            LocationHelper.shared.listen()
            
            centerMapOnLocation(location: LocationHelper.shared.getUserLocation())
            
            airportViewModel.populateSource(
                delegate: self,
                for: GlobalConstants.airportKey,
                inRegion: mapView.region)
            
        } else {
            LocationHelper
                .assignCallback(self)
                .listen()
        }
    }
    
    // MARK: This method centers Map to provided location
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(
                                    center: location.coordinate,
                                    latitudinalMeters: GlobalConstants.regionRadius,
                                    longitudinalMeters: GlobalConstants.regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: This method is responsible for plotting annotations on the map
    func plot() {
        
        setRightButtonItem(type: .refresh)
        
        for (index, _) in airportViewModel.airportModels.enumerated() {
            
            let annotation = airportViewModel.getAiportAnnotation(index: index)
            mapView.addAnnotation(annotation)
        }
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
}


// MARK: - Extension: AirportViewModelDelegate
extension AirportMapVC: AirportViewModelDelegate {
    
    // Call back when API search is finished
    func searchComplete() {
        self.plot()
    }
}


// MARK: - Extension : MKMapViewDelegate
extension AirportMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? MKPointAnnotation else { return nil }

        let identifier = "pin"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .system)
        }
        return view
    }
}


// MARK: - Extension - LocationAuthorizationStatus
extension AirportMapVC: LocationAuthorizationStatus {
    func statusAuthorizedAlways() {
        //Status Authorized Always for Location Services
        fetchUserLocation()
    }
    
    func statusAuthorizedWhenInUse() {
        //Status Authorized When In Use for Location Services
        fetchUserLocation()
    }
    
    func statusDenied() {
        //Status Denied for Location Services
        fetchUserLocation()
    }
    
    func statusNotDetermined() {
        //Status Not Determined for Location Services")
        //Don't navigate anywhere because after 1st time install
        //delegate will always receive notDetermined status
    }
    
    func statusRestricted() {
        //Status Restricted for Location Services")
        //Don't navigate anywhere
    }
    
    func userLocationUpdated() {
        // User location updated. Refresh data
        fetchUserLocation()
    }
}

