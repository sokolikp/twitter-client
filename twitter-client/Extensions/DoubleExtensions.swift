//
//  DoubleExtensions.swift
//  twitter-client
//
//  Created by Paul Sokolik on 10/8/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        let numerator = self * divisor
        return numerator.rounded() / divisor
    }
}
