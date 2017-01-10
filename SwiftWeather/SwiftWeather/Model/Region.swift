//
//  Region.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/5.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import SwiftyJSON

class Region: NSObject {
    
    var regionId:  String?
    
    
    private var _name: String?
    var name: String?{
        get{
            return _name ?? "未知"
        }
        set{
            _name = newValue
        }
    }
    
    var country: String?
    
    var path: String?
    
    
    override init() {
        super.init()
    }
    
    init(resultJson json: JSON?) {
        super.init()
        self.regionId = json?["id"].string
        self.name = json?["name"].string
        self.country = json?["country"].string
        self.path = json?["path"].string
    }
    

}
