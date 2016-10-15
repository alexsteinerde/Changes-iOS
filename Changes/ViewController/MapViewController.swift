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

class MapViewController: UIViewController, PulleyPrimaryContentControllerDelegate, MKMapViewDelegate {

    //MARK: Actions
    
    
    //MARK: Outlets
    
    
    //MARK: Attributes
    var mapView = MKMapView()
    
    //MARK: Main
    init() {
        super.init(nibName: nil, bundle: nil)
        mapView = MKMapView(frame: self.view.frame)
        mapView.delegate = self
        self.view.addSubview(mapView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let boundingBox = BoundingBox(latLeft: 52.212953, longLeft: 13.092054, latRight: 52.412953, longRight: 13.392054)
        Dataset.requestAll(forBoundingBox: boundingBox) { (datasets) in
            for dataset in datasets {
                if let plate = dataset as? Plate {
                    let annotation = PlateAnnotation(plate: plate)
                    self.mapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(52, 13.5), span: span)
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let drawer = self.parent as? PulleyViewController, let annotation = view.annotation as? PlateAnnotation
        {
            (drawer.drawerContentViewController as? DetailViewController)?.dataset = annotation.plate
            drawer.setDrawerPosition(position: .partiallyRevealed, animated: true)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
            mapView.setRegion(region, animated: true)
            mapView.regionThatFits(region)
        }      

    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        view.image = #imageLiteral(resourceName: "Plate.png")
        view.canShowCallout = false
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 1
        return view
    }
    
}
