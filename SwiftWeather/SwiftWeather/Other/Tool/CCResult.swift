//
//  CCResult.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/6.
//  Copyright © 2017年 ziooooo. All rights reserved.
//


import UIKit
import SwiftyJSON

protocol CCResultProtocol {
    func handle()
}

class CCResult : CCResultProtocol{
    
    var isSuccess: Bool! = false
    
    var error: Error?
    
    var json: JSON?

    func handle() {print("base result handle")}
}
