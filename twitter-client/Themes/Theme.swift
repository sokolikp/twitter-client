//
//  Theme.swift
//  twitter-client
//
//  Created by Paul Sokolik on 10/8/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    struct Colors {
        var twitterBlue = UIColor(displayP3Red: CGFloat(0)/255, green: CGFloat(172)/255, blue: CGFloat(237)/255, alpha: 1.0)
    }
    
    static func applyNavigationTheme() {
        UINavigationBar.appearance().barTintColor = Colors().twitterBlue
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}



