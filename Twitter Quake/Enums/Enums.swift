//
//  Enums.swift
//  Twitter Quake
//
//  Created by AppStarter on 15.03.2017.
//  Copyright © 2017 Krzysztof Hołtyn. All rights reserved.
//

import Foundation

enum Result<T, Error> {
    case success(T)
    case error(Error)
}
