//
//  Plate.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import Foundation
import CoreLocation

public class Plate : Dataset {
    var name: String
    var deportationDate: Date
    var deportationDestination: String
    var deathDate: Date
    var deathPlace: String
    
    init(name: String, deportationDate: Date, deportationDestination: String, deathDate: Date, deathPlace:String,  coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.deportationDate = deportationDate
        self.deportationDestination = deportationDestination
        self.deathDate = deathDate
        self.deathPlace = deathPlace
        super.init(coordinate: coordinate)
    }
    
    override init?(data: Dictionary<String, Any>) {
        guard let optional = data["data"] as? Dictionary<String, Any>,
            let name = optional["name"] as? String,
            let deportationDateString = optional["deportationDate"] as? String,
            let deportationDate = Plate.parseDate(ofString: deportationDateString),
            let deportationDestination = optional["deportationDestination"] as? String,
            let deathDateString = optional["deathDate"] as? String,
            let deathDate = Plate.parseDate(ofString: deathDateString),
            let deathPlace = optional["deathPlace"] as? String
            else { return nil }
        self.name = name
        self.deportationDate = deportationDate
        self.deportationDestination = deportationDestination
        self.deathDate = deathDate
        self.deathPlace = deathPlace
        
        super.init(data: data)
    }
    
    private static func parseDate(ofString string: String)->Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: string)
    }
}