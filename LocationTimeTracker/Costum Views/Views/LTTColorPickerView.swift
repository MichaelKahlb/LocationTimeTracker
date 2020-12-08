//
//  LTTColorPickerView.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 08.12.20.
//

import UIKit

class LTTColorPickerView: UIView {

    let colorFields: [UIView] = []
    private let colors: [UIColor] = [RegionColor.mint, RegionColor.blue, RegionColor.red, RegionColor.lightblue, RegionColor.orange, RegionColor.brown, RegionColor.green, RegionColor.magenta, RegionColor.violett]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        

        
        //Create ColorViews
        for i in 0...8 {
            let colorView = UIView()
            colorView.translatesAutoresizingMaskIntoConstraints = false
            colorView.backgroundColor = colors[i]
            let itemWidth = self.bounds.width / 9
            addSubview(colorView)
            NSLayoutConstraint.activate([
                colorView.topAnchor.constraint(equalTo: self.topAnchor),
                colorView.widthAnchor.constraint(equalToConstant: itemWidth),
                colorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: CGFloat(i) * itemWidth),
                colorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
            
        }
    }
    
}
