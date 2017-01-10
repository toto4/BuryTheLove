//
//  CCNetTool.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/6.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CCNetTool: NSObject {
    
    class func get<CCRes:CCResult>(from url:String ,
                   param:[String:Any] = [:],
                   resClass result:CCRes = CCResult() as! CCRes,
                   completionHandler: @escaping (CCRes) -> Void) {
        
        let requestUrlStr = API_HOST + url
        
        Alamofire.request(
            requestUrlStr,
            method: .get,
            parameters: param
            ).responseString { response in
                result.isSuccess = response.result.isSuccess
                result.error = response.result.error
                //处理结果
                let resStr = response.result.value ?? ""
                let resData = resStr.data(using: .utf8)
                result.json = JSON(data: resData!)
                result.handle()
                completionHandler(result)
        }
    }

}
