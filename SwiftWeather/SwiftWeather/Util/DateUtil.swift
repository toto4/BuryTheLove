//
//  DateUtil.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/17.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class DateUtil: NSObject {
    
    class func weekString(dateString: String?) -> String{
        
        
        guard let dateString = dateString else {
            return "未知"
        }
        
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let date = fmt.date(from: dateString)
        
        let today = Date()
        
        let canlendar: Calendar = Calendar.current
        
        let dateComponet = canlendar.dateComponents([.year, .month, .day, .weekday], from: date ?? today)
        
        let todayComponet = canlendar.dateComponents([.year, .month, .day, .weekday], from: today)
        
        if dateComponet.year == todayComponet.year, dateComponet.month == todayComponet.month, dateComponet.day == todayComponet.day {
            return "今天"
        }
        
        switch dateComponet.weekday ?? 99 {
        case 1:
            return "星期日"
        case 2:
            return "星期一"
        case 3:
            return "星期二"
        case 4:
            return "星期三"
        case 5:
            return "星期四"
        case 6:
            return "星期五"
        case 7:
            return "星期六"
        default:
            return "未知"
        }
        
        
        
    }
}
