//
//  Colour.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 22.11.20.
//

import UIKit

struct Color: Codable, Hashable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat?

    var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1)
    }
    
    
}
