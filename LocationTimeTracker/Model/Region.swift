//
//  Region.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 18.11.20.
//

import UIKit
import CoreLocation

struct Color: Codable {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat?

    var uiColor: UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1)
    }
}

struct Region: Codable {
    let name: String
    let colour: Color
    let radius: Double
    let lat: Double
    let lon: Double
}
