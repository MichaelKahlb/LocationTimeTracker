//
//  RegionInfoVC.swift
//  LocationTimeTracker
//
//  Created by Michael Kahlbacher on 01.12.20.
//

import UIKit
import MapKit

protocol RegionsDelegate: class {
    func didUpdateRegions()
}

class RegionInfoVC: UIViewController {

    var region: Region?
    var mapView: MKMapView!
    var overlay: MKCircle = MKCircle()
    var pickedColor:UIColor = .blue
    weak var delegate: RegionsDelegate?
    var name: String = "" {
        didSet {
            title = name
        }
    }
    var sdf = UISlider()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureMapView()
        configureColorfield()
        loadRegion()
        configureLpgr()
    }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = region?.name ?? "New Region"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTapped))
    }
    
    
    func configureMapView(){
        mapView = MKMapView()
        mapView.delegate = self
        mapView.isZoomEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView!)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    func configureColorfield() {
        let colorField = LTTColorPickerView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 20, height: 40))
        view.addSubview(colorField)
        NSLayoutConstraint.activate([
            colorField.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            colorField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            colorField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            colorField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func loadRegion(){
        guard let region = region else {
//            let picker = UIColorPickerViewController()
//            picker.delegate = self
//            picker.supportsAlpha = false
//            present(picker, animated: true, completion: nil)

            
            return
            
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
        let coordinate = CLLocationCoordinate2D(latitude: region.lat, longitude: region.lon)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(mapRegion, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = region.name
        mapView.addAnnotation(annotation)
        overlay = MKCircle(center: coordinate, radius: region.radius)
        mapView.addOverlay(overlay)
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
                        let color = Color(red: self.pickedColor.rgba.red, green: self.pickedColor.rgba.green, blue: self.pickedColor.rgba.blue, alpha: self.pickedColor.rgba.alpha)
                        self.region = Region(name: regionName, colour: color , radius: 10000, lat: coordinate.latitude, lon: coordinate.longitude)
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
                guard let self = self else { return }
                guard let error = error else {
                    return
                }
                print(error.rawValue)
            }
        }
        delegate?.didUpdateRegions()
        dismiss(animated: true)
    }
}

extension RegionInfoVC: MKMapViewDelegate, UIColorPickerViewControllerDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        var circleRenderer = MKCircleRenderer()
        if let overlay = overlay as? MKCircle {
            circleRenderer = MKCircleRenderer(circle: overlay)
            circleRenderer.fillColor = .systemRed
            //circleRenderer.strokeColor = .black
            circleRenderer.alpha = 0.3

        }
        return circleRenderer
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        pickedColor = viewController.selectedColor
        self.dismiss(animated: true, completion: nil)
    }
}

