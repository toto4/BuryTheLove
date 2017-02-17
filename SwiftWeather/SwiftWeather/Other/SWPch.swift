//
//  SWPch.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/3.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import SnapKit

func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor { return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a) }

let ColorBorder = RGBA(r:220,g: 220,b: 220,a: 1)

let ColorMain = RGBA(r: 0, g: 148, b: 222, a: 1)

let API_HOST = "https://api.thinkpage.cn/v3"

let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let EDGE_BASE: CGFloat = 10

let EDGE_TEXT: CGFloat = 15
		
