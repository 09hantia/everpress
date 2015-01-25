//
//  Current.swift
//  everpress
//
//  Created by Tianfei Han on 14-12-3.
//  Copyright (c) 2014年 Tianfei Han. All rights reserved.
//

import Foundation
import UIKit

struct Current {
    var currentTime: String!
    var temperature: Int
    var humidity: Double
    var precipProbability: Double
    var summary: String
    var icon: UIImage!
    
    init(weatherDictionary: NSDictionary){
        let currentWeather: NSDictionary = weatherDictionary["currently"] as NSDictionary
        
        temperature = currentWeather["temperature"] as Int
        humidity = currentWeather["humidity"] as Double
        precipProbability = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        
        let currentTimeIntValue = currentWeather["time"] as Int
        currentTime = dateStringFromUnixtime(currentTimeIntValue)
        
    }
    
    
    func dateStringFromUnixtime(unixTime: Int) -> String{
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
        
    }
    
    
    
}