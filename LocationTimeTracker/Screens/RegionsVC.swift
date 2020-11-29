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
        configureTableView()
        loadRegions()
        
        //TEST
        regions.append(Region(name: "Test654", colour: Color(red: 1, green: 1, blue: 0, alpha: 0.7), radius: 1, lat: 1, lon: 1))
        //TEST END
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(RegionCell.self, forCellReuseIdentifier: RegionCell.reuseIdentifier)
        
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

extension RegionsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegionCell.reuseIdentifier, for: indexPath) as! RegionCell
        cell.set(region: regions[indexPath.row])
        return cell
    }
    
    
}
