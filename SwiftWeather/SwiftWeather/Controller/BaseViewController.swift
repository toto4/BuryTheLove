//
//  BaseViewController.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/11.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var hideNavigationBar: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.hideNavigationBar == true {
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.hideNavigationBar == true {
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }

}
