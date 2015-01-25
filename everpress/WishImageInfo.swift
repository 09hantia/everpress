//
//  WishImageInfo.swift
//  everpress
//
//  Created by Tianfei Han on 15/1/7.
//  Copyright (c) 2015年 Tianfei Han. All rights reserved.
//

import Foundation
import UIKit

struct WishImageInfo{
    var wishId: Int!
    var userId: Int!
    var wishTypeCode: String!
    var wishPicId: Int!
    var picType: String!

    
    init(info: NSDictionary){
        wishId = info["wishId"] as Int
        userId = info["userId"] as Int
        wishTypeCode = info["wishTypeCode"] as String
        wishPicId = info["wishPicId"] as Int
        picType = info["picType"] as String
        
        
    }

}