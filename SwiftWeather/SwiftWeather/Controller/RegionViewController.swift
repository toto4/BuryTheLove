//
//  RegionViewController.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/9.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit

@objc protocol RegionViewControllerDelegate: NSObjectProtocol {
    @objc optional func regionViewController(didSearch region: Region)
}

class RegionViewController: BaseViewController ,UITableViewDataSource ,UITableViewDelegate ,UISearchBarDelegate {

    weak public var delegate: RegionViewControllerDelegate?
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var regionDataArr: [Region] = []
    
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择区域"
        self.setupComponent()
        self.setupSearchHistory()
    }
    
    func setupComponent() {
        self.definesPresentationContext = true
        
        //清空item
        let cleanItem = UIBarButtonItem(image: UIImage(named:"clean_icon"), style: .plain, target: self, action: #selector(cleanRegion))
        self.navigationItem.rightBarButtonItem = cleanItem
        
        //搜索结果显示控制器
        let resultVc = RegionSearchResultController()
        resultVc.parentController = self
        self.searchController = UISearchController.init(searchResultsController: resultVc)
        
        
        //SearchBar
        self.searchBar = self.searchController.searchBar
        self.searchBar.tintColor = ColorMain
        self.searchBar.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)
        self.searchBar.barTintColor = UIColor.groupTableViewBackground
        self.searchBar.delegate = self
        self.searchBar.placeholder = "例:北京,beijing,bj"
        
        
        //TableView
        self.tableView = UITableView()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.top.equalTo(self.view);
        }
        
        self.tableView.tableHeaderView = self.searchBar
        
        
    }
    
    //MARK: - 加载搜索历史
    func setupSearchHistory() {
        self.regionDataArr = DBUtil.default.regionSearchLogs()
        self.tableView.reloadData()
    }
    
    //MARK: - 搜索
    func searchRegion(keyWord:String) {
        WeatherNetUtil.searchRegion(keyWord: keyWord, completionHandler: {
            res in
            let resVc = self.searchController.searchResultsController as! RegionSearchResultController
            
            resVc.regionDataArr = res.regions
            resVc.tableView.reloadData()
        })
    }
    
    //MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.regionDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let region = self.regionDataArr[indexPath.row]
        
        self.delegate?.regionViewController?(didSearch: region)
        
        DBUtil.default.save(regionSearchLog: region)
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction.init(style: .default, title: "删除") { (action, index) in
            //删除数据
            let region = self.regionDataArr[index.row]
            
            DBUtil.default.deleteRegion(regionId: region.regionId!)
            
            self.regionDataArr = DBUtil.default.regionSearchLogs()
            
            tableView.deleteRows(at: [index], with: .left)
        }
        return [action]
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: - SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.searchRegion(keyWord: searchText)
        }
    }
    
    //MARK: - 清空地区信息
    func cleanRegion() {
        let alert = UIAlertController(title: "提示", message: "确定清空吗?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "再想想", style: .cancel, handler: nil)
        
        let doneAction = UIAlertAction(title: "确定", style: .default) { (action) in
            //清空数据
            DBUtil.default.cleanRegion()
            self.regionDataArr = DBUtil.default.regionSearchLogs()
            self.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
