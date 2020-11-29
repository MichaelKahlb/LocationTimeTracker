//
//  TimestampCell.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 23.11.20.
//

import UIKit

class TimestampCell: UITableViewCell {

    static let reuseIdentifier = "TimestampCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        accessoryType = .disclosureIndicator
    }
    
    func set(timeStamp: Timestamp) {
        textLabel?.text = timeStamp.timeValue + " " + timeStamp.region.name + " "
    }
}
