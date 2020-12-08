//
//  ColorSelectionVC.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 08.12.20.
//

import UIKit

class ColorSelectionVC: UIViewController {

    let tableView = UITableView()
    
    private let colors: [UIColor] = [RegionColor.mint, RegionColor.blue, RegionColor.red, RegionColor.lightblue, RegionColor.orange, RegionColor.brown, RegionColor.green, RegionColor.magenta, RegionColor.violett]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }

    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "color")
    }
    

}

extension ColorSelectionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "color", for: indexPath)
        cell.backgroundColor = colors[indexPath.row]
        return cell
        
    }
}
