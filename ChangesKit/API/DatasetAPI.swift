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
    
    private static let serverURL = ""
    
    class func requestData(forBounding: BoundingBox, completion: @escaping (_ data: Array<Dataset>)->Void) {
        Alamofire.request(serverURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let JSON = response.result.value as? Array<Dictionary<String, Any>> else { return completion([]) }
            var datasets = Array<Dataset>()
            for data in JSON {
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


struct BoundingBox {
    var latLeft: Double
    var longLeft: Double
    var latRight: Double
    var longRight: Double
}
