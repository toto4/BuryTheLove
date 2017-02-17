//
//  MenuViewController.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/2/16.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

let MENU_WIDTH = SCREEN_WIDTH * 0.4

class MenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let temp = UIView()
        temp.backgroundColor = UIColor(colorLiteralRed: 0.3, green: 0.1, blue: 1, alpha: 0.3)
        self.view.addSubview(temp)
        temp.snp.makeConstraints { (make) in
            make.right.equalTo(self.view)
            make.top.equalToSuperview().offset(200)
            make.size.equalTo(60)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(test))
        temp.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test() {
        print("1111111")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
