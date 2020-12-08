//
//  RegionCell.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 23.11.20.
//

import UIKit

class RegionCell: UITableViewCell {

    static let reuseIdentifier = "RegionCell"
    var colorField = UIView(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        accessoryType = .disclosureIndicator
        
        colorField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorField)
        NSLayoutConstraint.activate([
            
            colorField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            colorField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            colorField.widthAnchor.constraint(equalToConstant: 20),
            colorField.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    func set(region: Region) {
        textLabel?.text = region.name + "    " + String(region.radius)
        colorField.backgroundColor = region.colour.uiColor
        colorField.layer.cornerRadius = colorField.frame.size.width / 2
    }

}
