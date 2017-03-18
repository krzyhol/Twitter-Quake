//
//  EarthquakeService.swift
//  Twitter Quake
//
//  Created by AppStarter on 15.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

typealias EarthquakesResult = (quakes: [Quake], statusCode: Int)

struct EarthquakeService {    
    static func getEarthquakesAfter(numberOfDays days: Double, completion: @escaping (Result<EarthquakesResult, Swift.Error>) -> ()) {
        EarthquakeProvider.request(.quakesAfter(date: Date.dateSinceNow(days: days))) { result in
            switch result {
            case let .success(response):
                let statusCode = response.statusCode
                
                do {
                    let data = try response.mapJSON()
                    guard let JSON = data as? [String: Any] else { return }
                    guard let earthQuakesJSON = JSON["features"] as? [[String: Any]] else { return }
                    let earthQuakes = earthQuakesJSON.flatMap { Mapper<Quake>().map(JSON: $0) }
                    return completion(.success(quakes: earthQuakes, statusCode: statusCode))
                } catch {
                    return completion(.error(error))
                }
                
            case let .failure(error):
                return completion(.error(error))
            }
        }
    }
}
