//
//  Region.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 18.11.20.
//

import UIKit

struct Region: Codable, Hashable {
    let name: String
    var colour: Color
    let radius: Double
    let lat: Double
    let lon: Double
}
