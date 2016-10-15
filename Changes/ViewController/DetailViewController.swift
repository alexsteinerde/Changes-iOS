//
//  DetailViewController.swift
//  Changes
//
//  Created by Alex on 15/10/2016.
//  Copyright © 2016 Alex Steiner. All rights reserved.
//

import UIKit
import ChangesKit
import Pulley

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Actions
    
    
    //MARK: Outlets
    private var label = UILabel()
    private var tableView = UITableView()
    
    //MARK: Attributes
    var dataset: Dataset? {
        didSet {
            if let plate = dataset as? Plate {
                label.text = plate.name
                tableView.reloadData()
            }
        }
    }
    
    //MARK: Main
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.frame = CGRect(x: 20, y: 20, width: view.frame.width-40, height: 40)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        view.addSubview(label)
        
        tableView.frame = CGRect(x: 0, y: 80, width: view.frame.width, height: view.frame.height-60)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.clear
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont.systemFont(ofSize: 30)
        if let plate = dataset as? Plate {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = plate.deportationDestination
                cell.detailTextLabel?.text = "Deporation Destination"
            case 1:
                guard let date = plate.deportationDate else { break }
                let dateFormater = DateFormatter()
                dateFormater.dateStyle = .long
                cell.textLabel?.text = dateFormater.string(from: date)
                cell.detailTextLabel?.text = "Deporation Date"
            default:
                break
            }
        }
        else {
            cell.textLabel?.text = nil
            cell.detailTextLabel?.text = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
}
