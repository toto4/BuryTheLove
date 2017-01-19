//
//  WeatherNetUtil.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/9.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

/* 当前天气状况 */
let API_CURRENT = "/weather/now.json"
/* 未来三天 */
let API_DAILY = "/weather/daily.json"
/* 生活指数 */
let API_LIFE = "/life/suggestion.json"
/* 城市检索 */
let API_LOCATION = "/location/search.json"

/* 心知天气KEY */
let XINZHI_KEY = "ylzeyw46piirefwm"


class WeatherNetUtil: NSObject {
    /*
     城市ID 例如：location=WX4FBXXFKE4F
     城市中文名 例如：location=北京
     省市名称组合 例如：location=辽宁朝阳、location=北京朝阳
     城市拼音/英文名 例如：location=beijing（如拼音相同城市，可在之前加省份和空格，例：shanxi yulin）
     经纬度 例如：location=39.93:116.40（纬度前经度在后，冒号分隔）
     IP地址 例如：location=220.181.111.86（某些IP地址可能无法定位到城市）
     “ip”两个字母 自动识别请求IP地址，例如：location=ip
     */
    /// 当前天气
    class func getCurrentWeather(location: String ,completionHandler: @escaping(WeatherCurrentResult) -> Void){
        var param:[String:Any] = [:]
        param["key"] = XINZHI_KEY
        param["location"] = location
        CCNetTool.get(from: API_CURRENT, param: param, resClass: WeatherCurrentResult(), completionHandler:completionHandler)
    }
    
    /// 逐日天气
    class func getDailyWeather(location: String ,completionHandler: @escaping(WeatherDailyResult) -> Void){
        var param:[String:Any] = [:]
        param["key"] = XINZHI_KEY
        param["location"] = location
        CCNetTool.get(from: API_DAILY, param: param, resClass: WeatherDailyResult(), completionHandler:completionHandler)
    }
    
    /// 生活指数
    class func getLifeWeather(location: String ,completionHandler: @escaping(WeatherLifeResult) -> Void){
        var param:[String:Any] = [:]
        param["key"] = XINZHI_KEY
        param["location"] = location
        CCNetTool.get(from: API_LIFE, param: param, resClass: WeatherLifeResult(), completionHandler:completionHandler)
    }
    
    
    /*
     城市ID 例如：q=WX4FBXXFKE4F
     城市中文名 例如：q=北京
     省市名称组合 例如：q=辽宁朝阳、q=北京朝阳
     城市拼音/英文名 例如：q=beijing
     城市拼音缩写 例如：q=bj（仅支持中国城市）
     经纬度 例如：q=39.93:116.40（注意纬度前经度在后，冒号分隔）
     IP地址 例如：q=220.181.111.86（某些IP地址可能无法精确定位到城市）
     */
    
    /// 城市检索
    ///
    /// - Parameters:
    ///   - keyWord:
    ///   - completionHandler:
    class func searchRegion(keyWord: String ,completionHandler: @escaping(RegionResult) -> Void){
        var param:[String:Any] = [:]
        param["key"] = XINZHI_KEY
        param["q"] = keyWord
        param["limit"] = 30
        CCNetTool.get(from: API_LOCATION, param: param, resClass: RegionResult(), completionHandler:completionHandler)
    }

}
