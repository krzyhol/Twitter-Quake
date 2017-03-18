//
//  Quake.swift
//  Twitter Quake
//
//  Created by AppStarter on 15.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreLocation
import MapKit

class Quake: NSObject, Mappable, MKAnnotation {
    var quakeID: String
    var location: CLLocationCoordinate2D
    var magnitude: Double?
    var place: String?
    var time: Date?
    var numberOfFelt: Int?
    var alert: String?
    var tsunami: Bool?
    var significant: Int?
    var annotation: MKAnnotation?
    
    var coordinate: CLLocationCoordinate2D {
        return location
    }
    var title: String? {
        return place
    }
    var subtitle: String? {
        guard let magnitude = magnitude else { return nil }
        return "Magnitude: " + String(magnitude.roundTo(3))
    }
    
    required init?(map: Map) {
        quakeID  = ""
        location = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }
    
    func mapping(map: Map) {
        quakeID         <- map["id"]
        location        <- (map["geometry.coordinates"], transformLocationFromDoubles)
        magnitude       <- map["properties.mag"]
        place           <- map["properties.place"]
        time            <- (map["properties.time"], transformDateFromMilliseconds)
        numberOfFelt    <- map["properties.felt"]
        alert           <- map["properties.alert"] // ??ToDo: String -> Alert
        tsunami         <- (map["properties.tsunami"], transformBoolFromInt)
        significant     <- map["properties.sig"]
    }
    
    private let transformDateFromMilliseconds = TransformOf<Date, Double>(fromJSON: { (millisecondsInterval: Double?) -> Date? in
        guard let millisecondsInterval = millisecondsInterval else { return nil }
        
        return Date(timeIntervalSince1970: TimeInterval(millisecondsInterval / 1000.0))
    }, toJSON: { (date: Date?) -> Double? in
        guard let date = date else { return nil }
        
        return Double(date.timeIntervalSince1970)
    })
    
    private let transformBoolFromInt = TransformOf<Bool, Int>(fromJSON: { (value: Int?) -> Bool? in
        guard let value = value else { return nil }
        
        return value > 0
    }, toJSON: { (value: Bool?) -> Int? in
        guard let value = value else { return nil }
        
        return value ? 1 : 0
    })
    
    private let transformLocationFromDoubles = TransformOf<CLLocationCoordinate2D, [Double]>(fromJSON: { (values: [Double]?) -> CLLocationCoordinate2D? in
        guard let values = values else { return nil }
        
        return CLLocationCoordinate2D(latitude: values[1], longitude: values[0])
    }, toJSON: { (value: CLLocationCoordinate2D?) -> [Double]? in
        guard let value = value else { return nil }
        
        return [value.latitude, value.longitude]
    })
}
