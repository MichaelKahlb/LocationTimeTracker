//
//  RegioManager.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 30.11.20.
//

import UIKit
import CoreLocation

protocol RegionManagerDelegate: class {
    func didEnter(at region: Region)
    func didExit(at region: Region)
}

class RegionManager: NSObject {
    
    static let shared = RegionManager()
    let manager = CLLocationManager()
    var regions: [Region] = []
    weak var delegate : RegionManagerDelegate?
    
    private override init() {
        super.init()
        manager.delegate = self
    }
    
    
    func startMonitoring(for region: Region) {
        let coordiante = CLLocationCoordinate2D(latitude: region.lat, longitude: region.lon)
        let region = CLCircularRegion(center: coordiante, radius: region.radius, identifier: region.name)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.startMonitoringSignificantLocationChanges()
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
        region.notifyOnEntry = true
        region.notifyOnExit = true
        manager.startMonitoring(for: region)
    }
    
    
    func stopMonitoring(for region: Region) {
        let coordiante = CLLocationCoordinate2D(latitude: region.lat, longitude: region.lon)
        let region = CLCircularRegion(center: coordiante, radius: region.radius, identifier: region.name)
        manager.stopMonitoring(for: region)
    }
    
    
}

extension RegionManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        
        PersistenceManager.getRegion(for: region.identifier) { result in
            switch result {
            case .success(let region):
                print("region  \(region.name)  found")
                self.delegate?.didEnter(at: region)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        PersistenceManager.getRegion(for: region.identifier) { result in
            switch result {
            case .success(let region):
                print("region  \(region.name)  found")
                self.delegate?.didExit(at: region)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}
