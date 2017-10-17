//
//  DetailVC.swift
//  WeatherGift
//
//  Created by Daniel Lu on 10/16/17.
//  Copyright © 2017 Daniel Lu. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var currentPage = 0
    var locationsArray = [String]()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summarylabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = locationsArray[currentPage]
        
    }


}
