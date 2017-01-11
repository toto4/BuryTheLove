//
//  CurrentWeatherResult.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/9.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class CurrentWeatherResult: CCResult {
    
    var weatherCurrent: WeatherCurrent?
    
    override func handle() {
        self.weatherCurrent = WeatherCurrent(resultJson: self.json?["results"][0])
    }
}
