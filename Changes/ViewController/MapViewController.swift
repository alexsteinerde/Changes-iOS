//
//  MapViewController.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import UIKit
import ChangesKit
import Pulley
import MapKit

class MapViewController: UIViewController, PulleyPrimaryContentControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate {

    //MARK: Actions
    
    
    //MARK: Outlets
    
    
    //MARK: Attributes
    var mapView = MKMapView()
    let locationManager = CLLocationManager()
    var lastUpdate = Date(timeIntervalSinceNow: -30)
    
    //MARK: Main
    init() {
        super.init(nibName: nil, bundle: nil)
        mapView = MKMapView(frame: self.view.frame)
        mapView.delegate = self
        self.view.addSubview(mapView)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func zoomToUsersLocation() {
        guard let location = locationManager.location else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
        lastUpdate = Date(timeIntervalSinceNow: -30)
    }
    
    private func loadData() {
        guard lastUpdate.compare(Date(timeIntervalSinceNow: -20)) == .orderedAscending else  {
            return
        }
        lastUpdate = Date()
        let mRect = mapView.visibleMapRect
        let topLeft = MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMinX(mRect), mRect.origin.y))
        let bottomRight = MKCoordinateForMapPoint(MKMapPointMake(MKMapRectGetMaxX(mRect), MKMapRectGetMaxY(mRect)))
        
        let boundingBox = BoundingBox(latLeft: bottomRight.latitude, longLeft: topLeft.longitude, latRight: topLeft.latitude, longRight: bottomRight.longitude)
        Dataset.requestAll(forBoundingBox: boundingBox) { (datasets) in
            for dataset in datasets {
                if let plate = dataset as? Plate {
                    let annotation = PlateAnnotation(plate: plate)
                    self.mapView.addAnnotation(annotation)
                }
                else if let building = dataset as? Building {
                    let annotation = BuildingAnnotation(building: building)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let drawer = self.parent as? PulleyViewController
        {
            var frame = view.frame
            frame.size = CGSize(width: 55, height: 55)
            view.frame = frame
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 2
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            
            if let annotation = view.annotation as? PlateAnnotation {
                (drawer.drawerContentViewController as? DetailViewController)?.dataset = annotation.plate
            }
            else if let annotation = view.annotation as? BuildingAnnotation {
                (drawer.drawerContentViewController as? DetailViewController)?.dataset = annotation.building
            }
            drawer.setDrawerPosition(position: .partiallyRevealed, animated: true)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: view.annotation!.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            mapView.regionThatFits(region)
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        loadData()
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        var frame = view.frame
        frame.size = CGSize(width: 35, height: 35)
        view.frame = frame
        view.layer.borderWidth = 0
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        if annotation is PlateAnnotation {
            view.image = #imageLiteral(resourceName: "Plate.png")
        }
        else if let annotation = annotation as? BuildingAnnotation {
            annotation.building.fetchImage(completion: { (image) in
                view.image = image
                view.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
            })
        }
        view.canShowCallout = false
        view.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        return view
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        zoomToUsersLocation()
        manager.stopUpdatingLocation()
    }
    
}
