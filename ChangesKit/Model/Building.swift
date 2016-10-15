//
//  Building.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import Foundation
import CoreLocation

public class Building : Dataset {
    public var year: Int
    var hash: String
    private var image: UIImage?
    
    init(year: Int, hash: String, coordinate: CLLocationCoordinate2D) {
        self.year = year
        self.hash = hash
        super.init(coordinate: coordinate)
    }
    
    override init?(data: Dictionary<String, Any>) {
        guard let optional = data["data"] as? Dictionary<String, Any>,
            let images = optional["images"] as? Array<Dictionary<String, Any>>,
            let year = images.first?["year"] as? Int,
            let hash = images.first?["hash"] as? String
            else { return nil }
        self.year = year
        self.hash = hash
        
        super.init(data: data)
    }
    
    public func fetchImage(completion:@escaping (_ image: UIImage?)->Void) {
        if let image = image {
            completion(image)
            return
        }
        DatasetAPI.requestImage(withURL: "/img?hash=\(hash)") { (image) in
            self.image = image
            completion(image)
        }
    }
}
