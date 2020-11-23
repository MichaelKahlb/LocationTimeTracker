//
//  regionsVC.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 12.11.20.
//

import UIKit

class RegionsVC: UIViewController {
    
    let tableView = UITableView()
    var regions: [Region] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        loadRegions()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func loadRegions(){
        PersistenceManager.retrieveRegions { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let regions):
                self.regions = regions
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }

}
