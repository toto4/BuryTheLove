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

class RegionViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate ,UISearchBarDelegate {

    weak public var delegate: RegionViewControllerDelegate?
    
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var regionDataArr: [Region] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择区域"
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        self.setupComponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.searchBar.becomeFirstResponder()
    }
    
    func setupComponent() {
        
        //SearchBar
        self.searchBar = UISearchBar()
        self.searchBar.barTintColor = UIColor.groupTableViewBackground
        self.searchBar.delegate = self
        self.searchBar.placeholder = "例:北京,beijing,bj"
        self.view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
        }
        
        //TableView
        self.tableView = UITableView()
        self.tableView.backgroundColor = UIColor.white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self.view)
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        
        
        
    }
    
    func searchRegion(keyWord:String) {
        WeatherNetUtil.searchRegion(keyWord: keyWord, completionHandler: {
            res in
            self.regionDataArr = res.regions
            self.tableView.reloadData()
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
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
    
    //MARK: - SearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            self.searchRegion(keyWord: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    

}
