//
//  IntExtensions.swift
//  twitter-client
//
//  Created by Paul Sokolik on 10/8/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import Foundation

extension Int {
    func formatPrettyString() -> (String) {
        let num = Double(self)
        let thousandNum = num/1000
        let millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))K")
            }
            return("\(thousandNum.roundToPlaces(places: 1))K")
        }
        if num > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))K")
            }
            return ("\(millionNum.roundToPlaces(places: 1))M")
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
}
