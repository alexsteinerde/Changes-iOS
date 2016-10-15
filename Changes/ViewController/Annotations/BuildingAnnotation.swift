//
//  BuildingAnnotation.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import ChangesKit

class BuildingAnnotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D
    public var title: String?
    
    var building: Building
    
    init(building: Building) {
        self.building = building
        self.coordinate = building.coordinate
        self.title = String(building.year)
    }
}
