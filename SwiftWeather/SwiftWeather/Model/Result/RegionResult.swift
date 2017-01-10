//
//  RegionResult.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/9.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class RegionResult: CCResult {
    
    var regions: [Region] = []
    
    override func handle() {
        
        for regionJson in self.json?["results"].array ?? [] {
            let region = Region(resultJson: regionJson)
            
            if region.country == "CN" {//筛选中国地区
                regions.append(region)
            }
        }
        
    }
}
