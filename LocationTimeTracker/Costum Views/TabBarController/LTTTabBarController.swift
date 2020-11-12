//
//  LTTTabBarController.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 09.11.20.
//

import UIKit

class LTTTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createTimesNC(), createLocationOverviewNC()]
    }
    
    
    func createLocationOverviewNC()-> UINavigationController {
        let regionsVC = RegionsVC()
        regionsVC.title = Titles.regions
        regionsVC.tabBarItem = UITabBarItem(title: Titles.regions, image: SFSymbols.map, tag: 1)
        return UINavigationController(rootViewController: regionsVC)
    }
    
    func createTimesNC()-> UINavigationController {
        let timesVC = TimesVC()
        timesVC.title = Titles.times
        timesVC.tabBarItem = UITabBarItem(title: Titles.times, image: SFSymbols.clock, tag: 1)
        return UINavigationController(rootViewController: timesVC)
    }

}
