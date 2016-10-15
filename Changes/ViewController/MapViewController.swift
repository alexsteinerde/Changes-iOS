//
//  MapViewController.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import UIKit
import ChangesKit

class MapViewController: UIViewController {

    //MARK: Actions
    
    
    //MARK: Outlets
    
    
    //MARK: Attributes
    
    
    //MARK: Main
    override func viewDidLoad() {
        super.viewDidLoad()
        let boundingBox = BoundingBox(latLeft: 10, longLeft: 10, latRight: 100, longRight: 100)
        Dataset.requestAll(forBoundingBox: boundingBox) { (datasets) in
            print(datasets)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
