//
//  GFBodyLabel.swift
//  GitFollowoer
//
//  Created by Michael Kahlbacher on 28.03.20.
//  Copyright © 2020 com.MichaelKahlbacher. All rights reserved.
//

import UIKit

class LTTBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true    //Schrift automatisch anpassen
        minimumScaleFactor = 0.75           //Faktor wieviel geschrumpft werden darf
        lineBreakMode = .byWordWrapping    // texte werden normal umgebrochen
        translatesAutoresizingMaskIntoConstraints = false
        //Allgemein, keine numberOfLines, diese wird erst in den Viewcontrollern geschrieben.
    }

}
