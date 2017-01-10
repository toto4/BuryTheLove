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
    
    override init() {
        super.init()
    }
    
    init(resultJson json: JSON?) {
        super.init()
        self.text = json?["now"]["text"].string
        self.code = json?["now"]["code"].string
        self.temperature = json?["now"]["temperature"].string
        
        self.regoin = Region(resultJson: json?["location"])
    }
    
    
}
