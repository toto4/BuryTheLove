//
//  WeatherLife.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/11.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherLife: Weather {
    
    var lifeArray: [LifeSuggestion] = []
    
    override init(resultJson json: JSON?) {
        super.init(resultJson: json)
        
        let resDic = json?["suggestion"].dictionary ?? [:]
        
        for lifeDic in resDic {
            
            var sug = LifeSuggestion(name: lifeNameMapping(key: lifeDic.key))
            sug.setup(json: lifeDic.value)
            
            self.lifeArray.append(sug)
            
        }
    }
    
    func lifeNameMapping(key: String) -> String {
        switch key {
        case "car_washing":
            return "洗车"
        case "dressing":
            return "穿衣"
        case "flu":
            return "感冒"
        case "sport":
            return "运动"
        case "travel":
            return "旅游"
        case "uv":
            return "紫外线"
        default:
            return "未知"
        }
        
    }
}


struct LifeSuggestion {
    var name: String
    var brief: String?
    var details: String?
    
    init(name: String) {
        self.name = name
    }
    
    mutating func setup(json: JSON?) {
        self.brief = json?["brief"].string
        self.details = json?["details"].string
    }
    
}
