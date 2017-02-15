//
//  RegionSearchResultController.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/2/15.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

class RegionSearchResultController: UITableViewController {

    
    var regionDataArr: [Region] = []
    
    var parentController: RegionViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.regionDataArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "regionCellId"
        
        let region = self.regionDataArr[indexPath.row]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellId)
        }
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        
        cell?.textLabel?.text = region.name
        cell?.detailTextLabel?.text = region.path
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let region = self.regionDataArr[indexPath.row]
        
        self.parentController.delegate?.regionViewController?(didSearch: region)
        
        DBUtil.default.save(regionSearchLog: region)
        self.dismiss(animated: true) {
            _ = self.parentController.navigationController?.popViewController(animated: true)
        }
        
        
    }
}
