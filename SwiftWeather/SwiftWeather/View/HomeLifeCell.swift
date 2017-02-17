//
//  HomeLifeCell.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/17.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

let kHomeLifeCellId = "kHomeLifeCellId"
let kHomeLifeCellH: CGFloat = 25

class HomeLifeCell: UITableViewCell {
    
    var lifeNameLabel: UILabel!
    
    var lifeStateLabel: UILabel!
    
    var leftItem: LifeSuggestion?{
        didSet{
            self.lifeNameLabel.text = leftItem?.name.appending("：")
            self.lifeStateLabel.text = leftItem?.brief
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
        
        let textColor = ColorMain
        
        self.lifeNameLabel = UILabel()
        self.lifeNameLabel.textColor = textColor
        self.lifeNameLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        containView.addSubview(self.lifeNameLabel)
        self.lifeNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(containView.snp.centerX)
        }
        
        self.lifeStateLabel = UILabel()
        self.lifeStateLabel.textColor = textColor
        self.lifeStateLabel.font = UIFont.systemFont(ofSize: 13, weight: UIFontWeightThin)
        containView.addSubview(self.lifeStateLabel)
        self.lifeStateLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(containView.snp.centerX)
        }
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
