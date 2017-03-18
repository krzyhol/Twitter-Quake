//
//  EarthquakeEndpoint.swift
//  Twitter Quake
//
//  Created by AppStarter on 06.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import Foundation
import Moya

let EarthquakeProvider = MoyaProvider<Earthquake>()

struct APIConstants {
    static let earthquakeBaseURL = "https://earthquake.usgs.gov/fdsnws/event/1/"
}

enum Earthquake {
    case quakesAfter(date: Date)
}

extension Earthquake: TargetType {
    public var baseURL: URL {
        return URL(string: APIConstants.earthquakeBaseURL)!
    }
    var path: String {
        return "query"
    }
    var method: Moya.Method {
        return .get
    }
    var parameters: [String: Any]? {
        if case .quakesAfter(let date) = self {
            return ["format": "geojson", "starttime": date.iso8601, "minmagnitude": 5]
        }
        return nil
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    var sampleData: Data {
        return "{\"type\":\"FeatureCollection\",\"metadata\":{\"generated\":1489659403000,\"url\":\"https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02&minmagnitude=6\",\"title\":\"USGS Earthquakes\",\"status\":200,\"api\":\"1.5.7\",\"count\":1},\"features\":[{\"type\":\"Feature\",\"properties\":{\"mag\":6.5,\"place\":\"32km W of Sola, Vanuatu\",\"time\":1388592209000,\"updated\":1394151955000,\"tz\":660,\"url\":\"https://earthquake.usgs.gov/earthquakes/eventpage/usc000lvb5\",\"detail\":\"https://earthquake.usgs.gov/fdsnws/event/1/query?eventid=usc000lvb5&format=geojson\",\"felt\":null,\"cdi\":null,\"mmi\":4.84,\"alert\":\"green\",\"status\":\"reviewed\",\"tsunami\":1,\"sig\":650,\"net\":\"us\",\"code\":\"c000lvb5\",\"ids\":\",at00myqcls,pt14001000,usc000lvb5,\",\"sources\":\",at,pt,us,\",\"types\":\",cap,geoserve,impact-link,losspager,moment-tensor,moment-tensor,moment-tensor,moment-tensor,nearby-cities,origin,phase-data,shakemap,tectonic-summary,\",\"nst\":null,\"dmin\":3.997,\"rms\":0.76,\"gap\":14,\"magType\":\"mww\",\"type\":\"earthquake\",\"title\":\"M 6.5 - 32km W of Sola, Vanuatu\"},\"geometry\":{\"type\":\"Point\",\"coordinates\":[167.249,-13.8633,187]},\"id\":\"usc000lvb5\"}]}".data(using: .utf8)!
    }
    var task: Task {
        return .request
    }
}
