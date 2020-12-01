//
//  RegionInfoVC.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 01.12.20.
//

import UIKit
import MapKit

class RegionInfoVC: UIViewController {

    var region: Region?
    
    var mapView: MKMapView!
    
    var name: String = "" {
        didSet {
            title = name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureMapView()
        loadRegion()
        configureLpgr()
    }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = region?.name ?? "New Region"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    
    func configureMapView(){
        mapView = MKMapView(frame: view.bounds)
        mapView.isZoomEnabled = true
        view.addSubview(mapView!)
    }
    
    
    func loadRegion(){
        guard let region = region else { return }
        let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        let coordinate = CLLocationCoordinate2D(latitude: region.lat, longitude: region.lon)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(mapRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = region.name
        mapView.addAnnotation(annotation)
    }
    
    
    func configureLpgr(){
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(longpress(gestureRecognizer:)))
        uilpgr.minimumPressDuration = 2
        mapView.addGestureRecognizer(uilpgr)
    }
    
    
    @objc func longpress(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began{
            
            let touchpoint = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(touchpoint, toCoordinateFrom: mapView)
            
            if mapView.annotations.count == 0 {
                
                let alert = UIAlertController(title: "Name Your New Region", message: "", preferredStyle: .alert)
                
                alert.addTextField { (nametextField) in
                    nametextField.placeholder = "Name"
                }
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert, weak self] (_) in
                    guard let self = self else { return }
                    let textFieldName = alert?.textFields![0]
                    
                    if let regionName = textFieldName?.text {
                        self.region = Region(name: regionName, colour: Color(red: 1, green: 1, blue: 0, alpha: 0.7), radius: 10000, lat: coordinate.latitude, lon: coordinate.longitude)
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = regionName
                        self.name = regionName
                        self.mapView.addAnnotation(annotation)
                    }
                    //self.addNewAnnotation()
                    
                }))
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
                
            }
        }
    }
    
    @objc func saveTapped(){
        if let region = region {
            PersistenceManager.update(with: region, actionType: .add) { [weak self] (error) in
                guard self != nil else { return }
                guard let error = error else {
                    print("Saved")
                    return
                }
                print(error.rawValue)
            }
        }
        self.dismiss(animated: true)
    }
    
}
