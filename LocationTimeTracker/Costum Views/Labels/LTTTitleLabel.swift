//
//  GFTitleLabel.swift
//  GitFollowoer
//
//  Created by Michael Kahlbacher on 28.03.20.
//  Copyright © 2020 com.MichaelKahlbacher. All rights reserved.
//

import UIKit

class LTTTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth = true    //Schrift automatisch anpassen wenn text zu lange wird
        minimumScaleFactor = 0.9            //Faktor wieviel geschrumpft werden darf
        lineBreakMode = .byTruncatingTail   //Wenn text zu lang wird mit 3 pinkten abschliesen ...
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
