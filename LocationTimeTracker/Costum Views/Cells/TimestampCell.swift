//
//  TimestampCell.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 23.11.20.
//

import UIKit

class TimestampCell: UITableViewCell {

    static let reuseIdentifier = "TimestampCell"
    var colorField = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        accessoryType = .disclosureIndicator
        colorField.layer.cornerRadius = colorField.frame.size.width / 2
        addSubview(colorField)
    }
    
    func set(timeStamp: Timestamp) {
        textLabel?.text = timeStamp.timeValue + " " + timeStamp.region.name + " "
        colorField.backgroundColor = timeStamp.region.colour.uiColor
        switch timeStamp.action {
        case .enter:
            backgroundColor = .systemGreen
        default:
            backgroundColor = .systemRed
        }
    }
}
