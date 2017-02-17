//
//  CoverView.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/2/17.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class CoverView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0, alpha: 0.4)
        self.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        UIView.animate(withDuration: 0.3) { 
            self.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }

}
