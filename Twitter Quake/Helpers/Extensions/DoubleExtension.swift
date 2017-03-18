//
//  DoubleExtension.swift
//  Twitter Quake
//
//  Created by AppStarter on 15.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import Foundation

extension Double {
    func roundTo(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
