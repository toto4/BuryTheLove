//
//  WeatherDaily.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/11.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherDaily: Weather {
    
    var dailys: [Daily] = []
    
    override init(resultJson json: JSON?) {
        super.init(resultJson: json)
        for dailyJson in json?["daily"].array ?? [] {
            let daily = Daily(resultJson: dailyJson)
            dailys.append(daily)
        }
    }
}

class Daily: NSObject {
    //日期
    var date: String?
    //白天天气
    var textDay: String?
    var codeDay: String?
    //夜晚天气
    var textNight: String?
    var codeNight: String?
    //最高最低温度
    var high: String?
    var low: String?
    //降水概率 拿不到
    var precip: String?
    //风向
    var windDirection: String?
    //风向角度
    var windDirectionDegree: String?
    //风速 km/h
    var windSpeed: String?
    //风力等级
    var windScale: String?
    
    init(resultJson json: JSON?) {
        super.init()
        self.date = json?["date"].string
        self.textDay = json?["text_day"].string
        self.codeDay = json?["code_day"].string
        self.textNight = json?["text_night"].string
        self.codeNight = json?["code_night"].string
        self.high = json?["high"].string
        self.low = json?["low"].string
        self.precip = json?["precip"].string
        self.windDirection = json?["wind_direction"].string
        self.windDirectionDegree = json?["wind_direction_degree"].string
        self.windSpeed = json?["wind_speed"].string
        self.windScale = json?["wind_scale"].string
    }
}
