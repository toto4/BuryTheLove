//
//  DBUtil.swift
//  SwiftWeather
//
//  Created by ziooooo on 17/1/18.
//  Copyright © 2017年 ziooooo. All rights reserved.
//

import UIKit
import SQLite

let DB_PATH = "/SwiftWeather.sqlite"
let TABLE_REGION_SEARCH_LOG = "region_search_log"

let id = Expression<Int>("id")

final class DBUtil: NSObject {
    
    
    static let `default` = DBUtil()
    
    let db: Connection?
    
    private override init() {
        
        //判断是否已有数据库
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + DB_PATH
        print(path)
        if FileManager.default.fileExists(atPath: path) {
            self.db = DBUtil.initDB()
        } else {
            self.db = DBUtil.initDB()
            DBUtil.createTable(db: self.db)
        }
    }
    
    //初始化数据库
    class func initDB() -> Connection? {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return try? Connection(path + DB_PATH)
    }
    
    //建表
    class func createTable(db: Connection?) {
        //区域搜索历史
        let regionSearchLog = Table(TABLE_REGION_SEARCH_LOG)
        
        let regionId = Expression<String>("region_id")
        let name = Expression<String>("name")
        let country = Expression<String>("country")
        let path = Expression<String?>("path")
        
        try! db?.run(regionSearchLog.create(ifNotExists: true, block: { (table) in
            table.column(id, primaryKey: PrimaryKey.autoincrement)
            table.column(regionId, unique: true)
            table.column(name, unique: true)
            table.column(country)
            table.column(path)
        }))
        
        
    }
    
    //MARK:- Common
    
    
    
    //MARK:- 搜索历史操作
    func save(regionSearchLog region: Region) {
        
        let table = Table(TABLE_REGION_SEARCH_LOG)
        
        let insert = table.insert(Expression<String>("region_id") <- region.regionId!,
                                  Expression<String>("name") <- region.name!,
                                  Expression<String>("country") <- region.country!,
                                  Expression<String?>("path") <- region.path)
        _ = try? self.db?.run(insert)
        
    }
    
    func regionSearchLogs() -> [Region]{
        
        let table = Table(TABLE_REGION_SEARCH_LOG).order(id.desc)
        
        let rows = try! self.db?.prepare(table)
        
        var regions: [Region]! = []
        
        for row in rows! {
            let region = Region()
            region.regionId = row[Expression<String>("region_id")]
            region.name = row[Expression<String>("name")]
            region.country = row[Expression<String>("country")]
            region.path = row[Expression<String?>("path")]
            regions.append(region)
        }
        
        return regions
    }
    
    func deleteRegion(regionId: String) {
        
        let table = Table(TABLE_REGION_SEARCH_LOG)
        
        try! self.db?.run(table.filter(Expression<String>("region_id") == regionId).delete())
    }
    
    func cleanRegion() {
        let table = Table(TABLE_REGION_SEARCH_LOG)
        
        try! self.db?.run(table.delete())
    }
    
    
    
    

    
//    class func initDB() {
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let db = try? Connection("\(path)/SwiftWeather.sqlite3")
//        let users = Table("users")
//        let id = Expression<Int64>("id")
//        let name = Expression<String?>("name")
//        let email = Expression<String>("email")
//        
//        try! db?.run(users.create(ifNotExists: true, block: { (table) in
//            table.column(id, primaryKey: true)
//            table.column(name)
//            table.column(email, unique: true)
//        }))
//
//        
//        let insert = users.insert(name <- "究极死胖兽", email <- "scuxiatian@foxmail.com")
//        let rowid = (try! db?.run(insert))!
//        let insert2 = users.insert(name <- "Amazing7", email <- "360898864@qq.com")
//        let rowid2 = (try! db?.run(insert2))!
//        
//        for user in (try! db?.prepare(users))! {
//            print("Query:id: \(user[id]), name: \(user[name]), email: \(user[email])")
//        }
//        
//        let update = users.filter(id == rowid)
//        try! db?.run(update.update(email <- email.replace("foxmail", with: "qq")))
////
//        for user in (try! db?.prepare(users.filter(name == "究极死胖兽")))! {
//            print("Update:id: \(user[id]), name: \(user[name]), email: \(user[email])")
//        }
////
////        
////        try! db?.run(users.filter(id == rowid2).delete())
////        for user in (try! db?.prepare(users))! {
////            print("Delete:id: \(user[id]), name: \(user[name]), email: \(user[email])")
////        }
//    }

}
