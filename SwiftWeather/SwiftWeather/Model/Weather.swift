//
//  Weather.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/5.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import SwiftyJSON

class Weather: NSObject {
    
    var regoin: Region?
    
    var lastUpdate: String?
    
    override init() {
        super.init()
    }
    
    init(resultJson json: JSON?) {
        super.init()
        self.regoin = Region(resultJson: json?["location"])
        self.lastUpdate = json?["last_update"].string
    }
    
    
}
