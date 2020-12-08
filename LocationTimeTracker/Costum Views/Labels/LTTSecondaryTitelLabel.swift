//
//  GFSecondaryTitelLabel.swift
//  GitFollowoer
//
//  Created by Michael Kahlbacher on 02.11.20.
//  Copyright © 2020 com.MichaelKahlbacher. All rights reserved.
//

import UIKit

class LTTSecondaryTitelLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize)
    }
    
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true    //Schrift automatisch anpassen
        minimumScaleFactor = 0.90           //Faktor wieviel geschrumpft werden darf
        lineBreakMode = .byTruncatingTail    // texte werden normal umgebrochen
        translatesAutoresizingMaskIntoConstraints = false
        //Allgemein, keine numberOfLines, diese wird erst in den Viewcontrollern geschrieben.
    }

}
