//
//  WeatherCurrent.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/11.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import SwiftyJSON

class WeatherCurrent: Weather {

    private var _text: String?
    var text: String?{
        get{
            return _text ?? "未知"
        }
        set{
            _text = newValue
        }
    }
    
    private var _code: String?
    var code: String?{
        get{
            return _code ?? "99"
        }
        set{
            _code = newValue
        }
    }
    
    private var _temperature: String?
    var temperature: String?{
        get{
            return _temperature ?? "N/A"
        }
        set{
            _temperature = newValue
        }
    }
    
    override init(resultJson json: JSON?) {
        super.init(resultJson: json)
        self.text = json?["now"]["text"].string
        self.code = json?["now"]["code"].string
        self.temperature = json?["now"]["temperature"].string
    }
    
}
