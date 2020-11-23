//
//  Timestamp.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 18.11.20.
//

import Foundation


struct Timestamp: Codable, Hashable {
    let timeValue: String
    let region: Region
}