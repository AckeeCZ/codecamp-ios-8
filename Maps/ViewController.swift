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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    weak var mapView: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // nice pod for requesting permissions - https://github.com/nickoneill/PermissionScope

        let mapView = MKMapView()
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
        self.mapView = mapView

        updateAnnotaions()
    }

    func updateAnnotaions() {

        mapView.removeAnnotations(mapView.annotations)

        locations.forEach { location in
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(location["lat"]!, location["lon"]!)
            annotation.title = "Example location"
            mapView.addAnnotation(annotation)
        }
    }

    // MARK: Location delegate

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

    // MARK: MapView delegate

    let reuseIdentifier = "myAnnotationView"

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {

        // we want default blue mark for user's location
        if annotation is MKUserLocation {
            return nil
        }

        // dequeue annotation view or create new one
        let annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true

        let button = UIButton(type: .DetailDisclosure) // we could add target-action and create some interaction
        annotationView.rightCalloutAccessoryView = button

        let label = UILabel()
        label.text = "Detail label"
        label.font = UIFont.systemFontOfSize(10)
        annotationView.detailCalloutAccessoryView = label

        annotationView.draggable = true // that's nonsense here of course 😏 - just for example

        return annotationView
    }

    // MARK: Other

    let locations = [
        ["lat": 50.10155117, "lon": 14.50131164],
        ["lat": 50.04845155, "lon": 14.40643163],
        ["lat": 50.01436603, "lon": 14.48202576],
        ["lat": 50.09773545, "lon": 14.42862526],
        ["lat": 50.02386574, "lon": 14.418157],
        ["lat": 50.10891206, "lon": 14.50023615],
        ["lat": 50.13137991, "lon": 14.43188124],
        ["lat": 50.03085971, "lon": 14.43437316],
        ["lat": 50.05523586, "lon": 14.36531867],
        ["lat": 50.12467219, "lon": 14.39459484],
        ["lat": 50.00616185, "lon": 14.41959398],
        ["lat": 50.06693629, "lon": 14.43925259],
        ["lat": 50.08936261, "lon": 14.53516745],
        ["lat": 50.03396537, "lon": 14.48803967],
        ["lat": 50.06252636, "lon": 14.49942098],
        ["lat": 50.01692711, "lon": 14.37874073],
        ["lat": 50.07238541, "lon": 14.37937722],
        ["lat": 50.02807288, "lon": 14.51289626],
        ["lat": 50.0276592, "lon": 14.48751812],
        ["lat": 50.1340302, "lon": 14.45877785]
    ]
}
