//
//  Dataset.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import Foundation
import CoreLocation

public class Dataset {
    var coordinate:CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
    
    init?(data: Dictionary<String, Any>) {
        guard let lat = data["lat"] as? Double, let long = data["long"] as? Double else { return nil }
        self.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    public class func requestAll(forBoundingBox boundingBox: BoundingBox, completion:@escaping (_ datasets: Array<Dataset>)->Void) {
        DatasetAPI.requestData(forBounding: boundingBox, completion: completion)
    }
}
