//
//  UIDate+Ext.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 30.11.20.
//

import Foundation

extension Date {
    
    func convertToFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
    
}
