//
//  ViewController.swift
//  Maps
//
//  Created by Jan Mísař on 27.04.16.
//  Copyright © 2016 Ackee. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.requestWhenInUseAuthorization()

        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        view.addSubview(mapView)
        mapView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
        self.mapView = mapView
    }
}
