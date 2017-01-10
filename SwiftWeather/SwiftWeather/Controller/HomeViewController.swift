//
//  HomeViewController.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/3.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController ,RegionViewControllerDelegate {
    
    var cityNameLabel: UILabel!
    
    var weatherImageView: UIImageView!
    
    var weatherLabel: UILabel!
    
    var temperatureLabel: UILabel!
    
    var regionButton: UIButton!
    
    var weather: Weather?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        self.setupComponent()
        self.localWeatherData()
        
    }
    
    func setupComponent() {
        self.view.backgroundColor = UIColor.white
        
        //城市
        self.cityNameLabel = UILabel()
        self.cityNameLabel.textColor = UIColor.darkText
        self.cityNameLabel.font = UIFont.systemFont(ofSize: 30)
        self.view.addSubview(self.cityNameLabel)
        self.cityNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(40)
        }
        
        //天气图标
        self.weatherImageView = UIImageView()
        self.view.addSubview(self.weatherImageView)
        self.weatherImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.cityNameLabel)
            make.top.equalTo(self.cityNameLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 150, height: 150))
        }
        
        //天气名
        self.weatherLabel = UILabel()
        self.weatherLabel.textColor = UIColor.darkGray
        self.weatherLabel.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(self.weatherLabel)
        self.weatherLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.cityNameLabel)
            make.top.equalTo(self.weatherImageView.snp.bottom).offset(20)
        }
        
        //温度
        self.temperatureLabel = UILabel()
        self.temperatureLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.temperatureLabel)
        self.temperatureLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.cityNameLabel)
            make.top.equalTo(self.weatherLabel.snp.bottom).offset(20)
        }
        
        //选择地区按钮
        self.regionButton = UIButton()
        self.regionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.regionButton.setTitle("选择地区", for: .normal)
        self.regionButton.setTitleColor(UIColor.white, for: .normal)
        self.regionButton.backgroundColor = UIColor.blue
        self.regionButton.addTarget(self, action: #selector(chooseRegion), for: .touchUpInside)
        self.view.addSubview(self.regionButton)
        self.regionButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 70, height: 30))
            make.top.left.equalTo(20)
        }
        
    }
    
    //MARK:- 本地天气
    
    func localWeatherData() {
        self.weatherWithLocation(location: "ip")
    }
    
    //MARK:- 选择位置天气
    
    func weatherWithLocation(location: String) {
        WeatherNetUtil.getCurrentWeather(location: location, completionHandler: {
            result in
            
            self.weather = result.weather
            
            self.cityNameLabel.text = self.weather?.regoin?.name
            
            self.weatherImageView.image = UIImage(named: self.weather?.code ?? "")
            
            self.weatherLabel.text = self.weather?.text
            
            self.temperatureLabel.text = (self.weather?.temperature)! + "℃"
            
            if
                let temp = self.weather?.temperature ,
                let tempInt = Int(temp) ,
                tempInt > 0 {
                self.temperatureLabel.textColor = UIColor.red
            }
            else{
                self.temperatureLabel.textColor = UIColor.blue
            }
        })
    }
    
    //MARK:- 选择城市
    
    func chooseRegion() {
        
        let regionVc = RegionViewController()
        
        regionVc.delegate = self
        
        self.navigationController?.pushViewController(regionVc, animated: true)
        
    }
    
    //MARK:- 选择城市回调
    func regionViewController(didSearch region: Region) {
        
        self.weatherWithLocation(location: region.regionId ?? "")
        
    }
    
    
    //MARK:- 自己写的json字符串转对象
    
    func jsonObj(str:String?) -> Any? {
        
        guard let str = str else {
            return nil
        }
        
        guard let strData = str.data(using: .utf8) else {
            return nil
        }
        
        var obj:Any? = nil
        
        do {
            obj = try JSONSerialization.jsonObject(with: strData, options:.mutableContainers)
        } catch {
        }
        
        return obj
    }
}


