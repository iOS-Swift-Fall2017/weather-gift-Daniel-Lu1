//
//  TimeInterval+format.swift
//  WeatherGift
//
//  Created by Daniel Lu on 11/6/17.
//  Copyright © 2017 Daniel Lu. All rights reserved.
//

import Foundation



extension TimeInterval {
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
