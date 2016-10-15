//
//  HomeViewController.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import UIKit
import Pulley

class HomeViewController: PulleyViewController {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {
        let mainContentVC = MapViewController()
        
        let drawerContentVC = DetailViewController()
        super.init(contentViewController: mainContentVC, drawerViewController: drawerContentVC)
    }
    
    required init(contentViewController: UIViewController, drawerViewController: UIViewController) {
        super.init(contentViewController: contentViewController, drawerViewController: drawerViewController)
    }
}
