//
//  WeatherLifeResult.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/11.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class WeatherLifeResult: CCResult {
    
    var weatherLife: WeatherLife?
    
    override func handle()  {
        self.weatherLife = WeatherLife(resultJson: self.json?["results"][0])
    }
}
