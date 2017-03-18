//
//  APIRequestsTests.swift
//  Twitter Quake
//
//  Created by AppStarter on 16.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import Moya
import XCTest

@testable import Twitter_Quake

class APIRequestsTests: XCTestCase { }

extension APIRequestsTests {
    func testUrlBaseForEarthquake() {
        let baseURLFromAPIConstants = URL(string: APIConstants.earthquakeBaseURL)!
        XCTAssertEqual(baseURLFromAPIConstants, Earthquake.quakesAfter(date: Date()).baseURL)
    }
    
    func testPathForEarthquake() {
        XCTAssertEqual(("https://earthquake.usgs.gov/fdsnws/event/1/query"), Earthquake.quakesAfter(date: Date()).baseURL.absoluteString +  Earthquake.quakesAfter(date: Date()).path)
    }
    
    func testEarthquakeQuery() {
        let expectation = self.expectation(description: "request for todays earthquake")
        var response: Result<EarthquakesResult, Swift.Error>?

        EarthquakeService.getEarthquakesAfter(numberOfDays: 1.0) { result in
            response = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { _ in
            let status = 200
            if let response = response, case .success(let earthquakesResult) = response {
                XCTAssertEqual(status, earthquakesResult.statusCode)
            } else {
                XCTFail()
            }
        }
    }
    
    func testParseValidJSON() {
        do {
            try JSONSerialization.jsonObject(with: Earthquake.quakesAfter(date: Date()).sampleData, options: .allowFragments)
        } catch {
            XCTFail()
        }
    }
}
