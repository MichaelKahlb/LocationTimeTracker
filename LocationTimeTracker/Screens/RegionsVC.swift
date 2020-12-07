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
        loadRegions()
        configureViewController()
        configureTableView()
        print(RegionManager.shared.manager.monitoredRegions)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadRegions()
    }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
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
                self.tableView.reloadDataOnMainThread()
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    @objc func addTapped() {
        let destVC = RegionInfoVC()
        destVC.delegate = self
        navigationController?.pushViewController(destVC, animated: true)
        //let navController = UINavigationController(rootViewController: destVC)
        //present(navController, animated: true)
    }

}

extension RegionsVC: UITableViewDataSource, UITableViewDelegate, RegionsDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RegionCell.reuseIdentifier, for: indexPath) as! RegionCell
        cell.set(region: regions[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destVC = RegionInfoVC()
        destVC.region = regions[indexPath.row]
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersistenceManager.update(with: regions[indexPath.row], actionType: .remove) { [weak self] (error) in
                guard let self = self else { return }
                guard let error = error else {
                    self.regions.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    return
                }
                print(error.rawValue)
            }
        }
    }
    
    func didUpdateRegions() {
        loadRegions()
    }
}
