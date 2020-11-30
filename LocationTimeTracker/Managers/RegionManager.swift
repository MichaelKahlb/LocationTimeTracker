//
//  RegioManager.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 30.11.20.
//

import UIKit
import CoreLocation

class RegionManager: NSObject {
    
    static let shared = RegionManager()
    
    private override init() {
        super.init()
    }
    
    let manager = CLLocationManager()
    
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
        print("Entered \(region.identifier)")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit \(region.identifier)")
    }
}
