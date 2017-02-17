//
//  LoadingViewController.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/2/17.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    var titleContentView: UIView!
    var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let titleContentView = UIView()
        self.titleContentView = titleContentView
        titleContentView.backgroundColor = UIColor.white
        self.view.addSubview(titleContentView)
        titleContentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 80))
        }
        
        let titleLabel = UILabel()
        titleLabel.text = "Swift Weather"
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: UIFontWeightThin)
        titleContentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        let imgName = "a_weather_\(arc4random()%19)"
        
        let imageView = UIImageView()
        self.imageView = imageView
        imageView.alpha = 0
        imageView.image = UIImage(named: imgName)
        self.view.insertSubview(imageView, belowSubview: titleContentView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(80)
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseOut, animations: {
            self.titleContentView.transform = CGAffineTransform(translationX: 0, y: 50)
            self.imageView.transform = CGAffineTransform(translationX: 0, y: -50)
            self.imageView.alpha = 1
        }) { (end) in
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveLinear, animations: {
                self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                self.view.alpha = 0
            }) { (end) in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        }
    }
}
