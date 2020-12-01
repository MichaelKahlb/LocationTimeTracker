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
    var regions:[Region] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        loadTimes()
        RegionManager.shared.delegate = self
        //TESTTEST
        let region = Region(name: "Test654", colour: Color(red: 1, green: 1, blue: 0, alpha: 0.7), radius: 1, lat: 1, lon: 1)
        let timestamp = Timestamp(region: region, actionType: .exit)
        timeStamps.append(timestamp)
        
    }
    
    func configureViewController(){
        view.backgroundColor = .systemGray
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(TimestampCell.self, forCellReuseIdentifier: TimestampCell.reuseIdentifier)
    }
    
    func loadTimes(){
        PersistenceManager.retrieveTimestamps { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let timestamps):
                self.timeStamps = timestamps
            case .failure(let error):
                print(error)
            }
        }
        
    }

}

extension TimesVC: UITableViewDelegate, UITableViewDataSource, RegionManagerDelegate {
    
    func didEnter(at CLRegion: CLRegion) {
        print("deleagta workd")
    }
    
    func didExit(at CLRegion: CLRegion) {
        print("deleagta workd")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        timeStamps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TimestampCell.reuseIdentifier, for: indexPath) as! TimestampCell
        cell.set(timeStamp: timeStamps[indexPath.row])
        return cell
        
    }
    
    
}
