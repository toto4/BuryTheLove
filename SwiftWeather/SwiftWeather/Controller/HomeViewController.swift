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

class HomeViewController: BaseViewController ,RegionViewControllerDelegate ,UITableViewDataSource ,UITableViewDelegate {
    
    var tableview: UITableView!
    
    var cityNameLabel: UILabel!
    
    var weatherImageView: UIImageView!
    
    var weatherLabel: UILabel!
    
    var temperatureLabel: UILabel!
    
    var regionButton: UIButton!
    
    let refreshControl = UIRefreshControl()
    
    var weatherCurrent: WeatherCurrent?
    
    var weatherDaily: WeatherDaily?
    
    var weatherLife: WeatherLife?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.hideNavigationBar = true
        
        self.setupComponent()
        self.localWeatherData()
        
    }
    
    func setupComponent() {

        self.tableview = UITableView(frame: CGRect.zero, style: .grouped)
        self.tableview.backgroundColor = UIColor.white
        self.tableview.register(HomeWeatherCell.classForCoder(), forCellReuseIdentifier: kHomeWeatherCellId)
        self.tableview.register(HomeLifeCell.classForCoder(), forCellReuseIdentifier: kHomeLifeCellId)
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.showsVerticalScrollIndicator = false
        self.tableview.separatorStyle = .none
        self.view.addSubview(self.tableview)
        self.tableview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 320)
        self.tableview.tableHeaderView = headerView
        
        self.tableview.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: EDGE_TEXT))
        
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableview.addSubview(self.refreshControl)
        
        //城市
        self.cityNameLabel = UILabel()
        self.cityNameLabel.textColor = UIColor.darkText
        self.cityNameLabel.font = UIFont.systemFont(ofSize: 32, weight: UIFontWeightThin)
        headerView.addSubview(self.cityNameLabel)
        self.cityNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(headerView).offset(60)
        }
        
        //天气名
        self.weatherLabel = UILabel()
        self.weatherLabel.textColor = UIColor.darkGray
        self.weatherLabel.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin)
        headerView.addSubview(self.weatherLabel)
        self.weatherLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.cityNameLabel)
            make.top.equalTo(self.cityNameLabel.snp.bottom).offset(5)
        }
        
        //天气图标
        self.weatherImageView = UIImageView()
        headerView.addSubview(self.weatherImageView)
        self.weatherImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.cityNameLabel)
            make.top.equalTo(self.weatherLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        //温度
        self.temperatureLabel = UILabel()
        self.temperatureLabel.font = UIFont.systemFont(ofSize: 90, weight: UIFontWeightUltraLight)
        self.temperatureLabel.textColor = UIColor.darkText
        headerView.addSubview(self.temperatureLabel)
        self.temperatureLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.cityNameLabel)
            make.top.equalTo(self.weatherImageView.snp.bottom).offset(0)
        }
        
        //度°
        let symbolLabel = UILabel()
        symbolLabel.text = "°"
        symbolLabel.textColor = UIColor.darkText
        symbolLabel.font = UIFont.systemFont(ofSize: 50, weight: UIFontWeightUltraLight)
        headerView.addSubview(symbolLabel)
        symbolLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.temperatureLabel).offset(6)
            make.left.equalTo(self.temperatureLabel.snp.right)
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
    
    //MARK:- TableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.weatherDaily?.dailys.count ?? 0
        }
        return self.weatherLife?.lifeArray.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let daily = self.weatherDaily?.dailys[indexPath.row]
            
            let cell: HomeWeatherCell = tableview.dequeueReusableCell(withIdentifier: kHomeWeatherCellId) as! HomeWeatherCell
            
            cell.daily = daily
            
            return cell
        } else {
            
            let lifeItem = self.weatherLife?.lifeArray[indexPath.row]
            
            let cell: HomeLifeCell = tableview.dequeueReusableCell(withIdentifier: kHomeLifeCellId) as! HomeLifeCell
            
            cell.leftItem = lifeItem
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return kHomeWeatherCellH
        } else {
            return kHomeLifeCellH
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return EDGE_TEXT
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let tempFooter = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 10))
        tempFooter.backgroundColor = UIColor.white
        return tempFooter
    }
    
    //MARK:- 本地天气
    
    func localWeatherData() {
        self.weatherWithLocation(location: "ip")
    }
    
    //MARK:- 选择位置天气
    func weatherWithLocation(location: String) {
        //当前天气
        WeatherNetUtil.getCurrentWeather(location: location, completionHandler: {
            result in
            
            self.refreshControl.endRefreshing()
            
            self.weatherCurrent = result.weatherCurrent
            
            self.cityNameLabel.text = self.weatherCurrent?.regoin?.name
            
            self.weatherImageView.image = UIImage(named: self.weatherCurrent?.code ?? "")
            
            self.weatherLabel.text = self.weatherCurrent?.text
            
            self.temperatureLabel.text = (self.weatherCurrent?.temperature)!
        })
        //未来三天
        WeatherNetUtil.getDailyWeather(location: location, completionHandler: {
            result in
            
            self.weatherDaily = result.weatherDaily
            self.tableview.reloadData()
            
        })
        
        //生活指数
        WeatherNetUtil.getLifeWeather(location: location, completionHandler: {
            result in
            
            self.weatherLife = result.weatherLife
            self.tableview.reloadData()
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
        
        self.weatherWithLocation(location: region.name ?? "")
        
    }
    
    //MARK:- 刷新
    
    func refresh() {
        self.weatherWithLocation(location: "ip")
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


