//
//  PlateAnnotation.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import UIKit
import MapKit
import ChangesKit

class PlateAnnotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    
    var plate:Plate
    
    init(plate: Plate) {
        self.plate = plate
        self.coordinate = plate.coordinate
        self.title = plate.name
    }
}
