//
//  UITableView+Ext.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 29.11.20.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
