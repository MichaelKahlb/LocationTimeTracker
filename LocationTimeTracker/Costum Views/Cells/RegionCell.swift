//
//  RegionCell.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 23.11.20.
//

import UIKit

class RegionCell: UITableViewCell {

    static let reuseIdentifier = "RegionCell"
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
        addSubview(colorField)
        colorField.layer.cornerRadius = colorField.frame.size.width / 2
        colorField.backgroundColor = .red
        //Todoo
        NSLayoutConstraint.activate([

        ])
        //Add Constrain
    }
    
    func set(region: Region) {
        textLabel?.text = region.name + "    " + String(region.radius)
        colorField.backgroundColor = region.colour.uiColor
    }

}
