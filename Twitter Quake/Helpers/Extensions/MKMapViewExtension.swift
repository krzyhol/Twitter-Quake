//
//  MKMapViewExtension.swift
//  Twitter Quake
//
//  Created by AppStarter on 16.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import MapKit

extension MKMapView {
    func centerMapOnLocation(_ location: CLLocationCoordinate2D, withRadius radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
                                                                  radius * 2.0, radius * 2.0)
        setRegion(coordinateRegion, animated: true)
    }
    
    func addAnnotation(_ annotation: MKAnnotation, withSelected selected: Bool) {
        addAnnotation(annotation)
        if selected {
            selectAnnotation(annotation, animated: true)
        }
    }
}
