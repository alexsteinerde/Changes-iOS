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
            print(response)
        }
    }
}


struct BoundingBox {
    var latLeft: Double
    var longLeft: Double
    var latRight: Double
    var longRight: Double
}
