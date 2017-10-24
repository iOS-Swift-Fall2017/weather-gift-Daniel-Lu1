//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Daniel Lu on 10/23/17.
//  Copyright © 2017 Daniel Lu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    
    func getWeather(completed: @escaping () -> ()) {
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        Alamofire.request(weatherURL).responseJSON {
            response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let temperature = json["currently"]["temperature"].double {
                        print("***** TEMP inside getWeater = \(temperature)")
                        let roundedTemp = String(format: "%3.f", temperature)
                        self.currentTemp = roundedTemp + "°"
                    } else {
                        print("Can't get temperature")
                    }
                case .failure(let error):
                    print(error)
                }
            completed()
        }
    }
}
