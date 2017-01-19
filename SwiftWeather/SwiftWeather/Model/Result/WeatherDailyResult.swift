//
//  WeatherDailyResult.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/11.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class WeatherDailyResult: CCResult {
    
    var weatherDaily: WeatherDaily?
    
    override func handle() {
        self.weatherDaily = WeatherDaily(resultJson: self.json?["results"][0])
    }
}
