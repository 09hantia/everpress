//
//  Everpress.swift
//  everpress
//
//  Created by Tianfei Han on 14-12-9.
//  Copyright (c) 2014年 Tianfei Han. All rights reserved.
//

import Foundation
import UIKit

struct Information{
    var clientId: Int!
    var firstName: String!
    var lastName: String!
    var email: String!
    var phoneNumber: String!
    var lastModifiedBy: String!
    var lastModifiedDate: String!
    
    init(info: NSDictionary){
        clientId = info["clientId"] as Int
        firstName = info["firstName"] as String
        lastName = info["lastName"] as String
        email = info["email"] as String
        phoneNumber = info["phoneNumber"] as String
        lastModifiedBy = info["lastModifiedBy"] as String
        let lastModifiedDateInt = info["lastModifiedDate"] as Int
        //lastModifiedDate = dateStringFromUnixtime(lastModifiedDateInt)
    
    }
    
    func dateStringFromUnixtime(unixTime: Int) -> String{
        let timeInSeconds = NSTimeInterval(unixTime)
        let weatherDate = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(weatherDate)
        
    }

}