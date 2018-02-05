//
//  HomeWeatherCell.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/13.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

let kHomeWeatherCellId = "kHomeWeatherCellId"
let kHomeWeatherCellH: CGFloat = 60


class HomeWeatherCell: UITableViewCell {
    
    var dateLabel: UILabel!
    
    var dayLabel: UILabel!
    
    var stateDayLabel: UILabel!
    
    var stateNightLabel: UILabel!
    
    var stateDayImageView: UIImageView!
    
    var stateNightImageView: UIImageView!
    
    var temperatureLabel: UILabel!
    
    var daily: Daily?{

        didSet{

            //设置UI
            let dateStr = daily?.date
            let index = dateStr?.index((dateStr?.startIndex)!, offsetBy: 5)
            self.dateLabel.text = dateStr?.substring(from: index!)
            //处理日期显示星期
            self.dayLabel.text = DateUtil.weekString(dateString: dateStr)
            self.stateDayLabel.text = daily?.textDay
            self.stateNightLabel.text = daily?.textNight
            self.stateDayImageView.image = UIImage(named: "\(daily?.codeDay ?? "99")")
            self.stateNightImageView.image = UIImage(named: "\(daily?.codeNight ?? "99")")
            self.temperatureLabel.text = "\(daily?.high ?? "NaN")    \(daily?.low ?? "NaN")"
            
            if daily?.codeDay == daily?.codeNight {
                self.stateNightLabel.isHidden = true
                self.stateNightImageView.isHidden = true
                
                self.stateDayLabel.snp.updateConstraints({ (make) in
                    make.centerX.equalToSuperview()
                })
                
            }else{
                self.stateNightLabel.isHidden = false
                self.stateNightImageView.isHidden = false
                
                self.stateDayLabel.snp.updateConstraints({ (make) in
                    make.centerX.equalToSuperview().offset(-30)
                })
            }
        }
    }
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let containView = UIView()
        self.contentView.addSubview(containView)
        containView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        //日期
        self.dateLabel = UILabel()
        self.dateLabel.textColor = UIColor.darkGray
        self.dateLabel.font = UIFont.systemFont(ofSize: 12)
        containView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(EDGE_BASE)
            make.left.equalToSuperview().offset(EDGE_TEXT)
        }
        
        //今天
        self.dayLabel = UILabel()
        self.dayLabel.textColor = UIColor.darkGray
        self.dayLabel.font = UIFont.systemFont(ofSize: 12)
        containView.addSubview(self.dayLabel)
        self.dayLabel.snp.makeConstraints { (make) in
            make.left.equalTo(dateLabel)
            make.bottom.equalToSuperview().offset(-EDGE_BASE)
        }
        
        self.stateDayLabel = UILabel()
        self.stateDayLabel.textColor = UIColor.darkText
        self.stateDayLabel.font = UIFont.systemFont(ofSize: 12)
        containView.addSubview(self.stateDayLabel)
        self.stateDayLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel)
            make.centerX.equalToSuperview().offset(-30)
        }
        
        self.stateDayImageView = UIImageView()
        containView.addSubview(self.stateDayImageView)
        self.stateDayImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(dayLabel).offset(5)
            make.centerX.equalTo(stateDayLabel)
            make.size.equalTo(25)
        }
        
        self.stateNightLabel = UILabel()
        self.stateNightLabel.textColor = UIColor.darkText
        self.stateNightLabel.font = UIFont.systemFont(ofSize: 12)
        containView.addSubview(self.stateNightLabel)
        self.stateNightLabel.snp.makeConstraints { (make) in
            make.top.equalTo(dateLabel)
            make.centerX.equalToSuperview().offset(30)
        }
        
        self.stateNightImageView = UIImageView()
        containView.addSubview(self.stateNightImageView)
        self.stateNightImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(stateDayImageView)
            make.centerX.equalTo(stateNightLabel)
            make.size.equalTo(stateDayImageView)
        }
        
        self.temperatureLabel = UILabel()
        self.temperatureLabel.textColor = UIColor.darkText
        self.temperatureLabel.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        containView.addSubview(self.temperatureLabel)
        self.temperatureLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-EDGE_TEXT)
            make.centerY.equalToSuperview()
        }
        
        //CutLine
        let cutLine = UIView()
        cutLine.backgroundColor = ColorBorder
        containView.addSubview(cutLine)
        cutLine.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.7)
            make.left.equalToSuperview().offset(EDGE_TEXT)
            make.right.equalToSuperview().offset(-EDGE_TEXT)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}
