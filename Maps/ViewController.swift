//
//  ViewController.swift
//  Maps
//
//  Created by Jan Mísař on 27.04.16.
//  Copyright © 2016 Ackee. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // nice pod for requesting permissions - https://github.com/nickoneill/PermissionScope

        let mapView = MKMapView()
        view.addSubview(mapView)
        mapView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
        self.mapView = mapView
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways {
            mapView.showsUserLocation = true
            mapView.userTrackingMode = .Follow

            locationManager.startUpdatingLocation() // we should also stop it somewhere!
        } else {
            print("Alert - Hey user! Go to settings and give me permissions!")
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last! // we are sure we have at least one location there
        print(lastLocation)
    }
}
