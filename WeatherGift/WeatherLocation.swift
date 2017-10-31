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
    struct DailyForecast {
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailySummary: String
        var dailyIcon: String
    }
    
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = ""
    var currentIcon = ""
    var timeZone = ""
    var time = 0.0
    var dailyForecastArray = [DailyForecast]()
    
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
                    if let summary = json["daily"]["summary"].string {
                        self.currentSummary = summary
                    } else {
                        print("No summary")
                    }
                    if let icon = json["currently"]["icon"].string {
                        self.currentIcon = icon
                    } else {
                        print("No icon")
                    }
                    if let timeZone = json["timezone"].string {
                        self.timeZone = timeZone
                    } else {
                        print("No timeZone")
                    }
                    if let time = json["currently"]["time"].double {
                        self.time = time
                    } else {
                        print("No time")
                    }
                    let dailyDataArray = json["daily"]["data"]
                    self.dailyForecastArray = []
                    for day in 1...dailyDataArray.count-1 {
                        let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                        let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                        let dateValue = json["daily"]["data"][day]["time"].doubleValue
                        let icon = json["daily"]["data"][day]["icon"].stringValue
                        let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                        
                        let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailySummary: dailySummary, dailyIcon: icon)
                        self.dailyForecastArray.append(newDailyForecast)
                    }
                case .failure(let error):
                    print(error)
                }
            completed()
        }
    }
}
