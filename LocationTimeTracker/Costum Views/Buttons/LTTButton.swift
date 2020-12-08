//
//  GFButton.swift
//  GitFollowoer
//
//  Created by Michael Kahlbacher on 05.02.20.
//  Copyright © 2020 com.MichaelKahlbacher. All rights reserved.
//

import UIKit

class LTTButton: UIButton {

    override init(frame: CGRect) { // Muss aufgerufen werden damit der Standard Apple Init durchläuft.
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) { //req Init benötigt nur bei Ini über Storyboard
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backGroundColor: UIColor) { //Costum Init, damit Title und Farbe von beim neu erstellen eines Button angegeben wird
        self.init(frame: .zero) //brach ma net weil die größe eh mit den Layout Constraints bestimmt wird.
        self.backgroundColor = backGroundColor
    }
    
    private func configure() {      //Private = Funktion kann nur in der Klasse ausgeführt werden, nicht jedoch in einer Instanz von diesem Button
        layer.cornerRadius      = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline) // Damit die Texte die größe ändern
        translatesAutoresizingMaskIntoConstraints = false // Use auto Layout
        
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
    }
    
}
