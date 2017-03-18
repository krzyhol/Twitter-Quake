//
//  QuakeDetailsViewController.swift
//  Twitter Quake
//
//  Created by AppStarter on 16.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

final class QuakeDetailsViewController: UIViewController {
    
    private struct ViewContants {
        static let regionRadius: CLLocationDistance = 100000
    }
    
    @IBOutlet private weak var mapView: MKMapView!

    var quake: Quake?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let quake = quake else { return }
        mapView.centerMapOnLocation(quake.coordinate, withRadius: ViewContants.regionRadius)
        mapView.addAnnotation(quake, withSelected: true)
    }
}
