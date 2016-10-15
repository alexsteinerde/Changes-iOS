//
//  DatasetAPI.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import Foundation
import Alamofire

class DatasetAPI {
    
    private static let serverURL = "https://changes.plantio.de"
    
    class func requestData(forBounding box: BoundingBox, completion: @escaping (_ data: Array<Dataset>)->Void) {
        Alamofire.request(serverURL + "/get?leftLat=\(box.latLeft)&leftLong=\(box.longLeft)&rightLat=\(box.latRight)&rightLong=\(box.longRight)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let JSON = response.result.value as? Dictionary<String, Any>, let answer = JSON["answer"] as? Array<Dictionary<String, Any>> else { return completion([]) }
            var datasets = Array<Dataset>()
            for data in answer {
                if data["type"] as? String == "plate" {
                    if let plate = Plate(data: data) {
                        datasets.append(plate)
                    }
                }
            }
            completion(datasets)
        }
    }
}


public struct BoundingBox {
    var latLeft: Double
    var longLeft: Double
    var latRight: Double
    var longRight: Double
    
    public init(latLeft: Double, longLeft: Double, latRight: Double, longRight: Double) {
        self.latLeft = latLeft
        self.longLeft = longLeft
        self.latRight = latRight
        self.longRight = longRight
    }
}
