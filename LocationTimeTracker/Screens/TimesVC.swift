//
//  timesVC.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 12.11.20.
//

import UIKit
import CoreLocation

class TimesVC: UIViewController {

    var timeStamps:[Timestamp] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    func configureViewController(){
        view.backgroundColor = .systemGreen
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
