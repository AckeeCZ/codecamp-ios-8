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

    override func viewDidLoad() {
        super.viewDidLoad()

        let mapView = MKMapView()
        view.addSubview(mapView)
        mapView.snp_makeConstraints { make in
            make.edges.equalTo(0)
        }
        self.mapView = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
