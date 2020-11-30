//
//  Timestamp.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 18.11.20.
//

import Foundation

enum TimestampAction: String, Codable {
    case exit = "exit"
    case enter = "enter"
}

struct Timestamp: Codable, Hashable {
    var timeValue: String {
        return Date().convertToManthYearFormat()
    }
    let region: Region
    let action: TimestampAction
    
    init(region: Region, actionType: TimestampAction) {
        self.region = region
        self.action = actionType
    }

}
