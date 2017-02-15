//
//  LocalConfigUtil.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/2/15.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

let CONFIG_CURRENT_REGION_ID_KEY = "CONFIG_CURRENT_REGION_ID_KEY"


class LocalConfigUtil: NSObject {

    
    class func currentRegionId() -> String? {
        
        return UserDefaults.standard.string(forKey: CONFIG_CURRENT_REGION_ID_KEY)
    }
    
    class func save(currentRegionId:String) {
        UserDefaults.standard.set(currentRegionId, forKey: CONFIG_CURRENT_REGION_ID_KEY)
        UserDefaults.standard.synchronize()
    }
    
    
}
