//
//  DateExtension.swift
//  Twitter Quake
//
//  Created by AppStarter on 14.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import Foundation

extension Date {
    static let iso8601Formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    var iso8601: String {
        return Date.iso8601Formatter.string(from: self)
    }
    static func dateSinceNow(days: Double) -> Date {
        return Date(timeIntervalSinceNow: -days * 24.0 * 60.0 * 60.0)
    }
}
