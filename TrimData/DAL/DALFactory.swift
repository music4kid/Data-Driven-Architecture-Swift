//
//  DALFactory.swift
//  TrimData
//
//  Created by gao feng on 16/2/26.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import SQLite

var _DAL = DALFactory.sharedInstance

var dbQueue = DispatchQueue(label: "TrimData.DB.SerialQueue")

class DALFactory: NSObject {
    static var sharedInstance = DALFactory()
    
    var gitHubDal: GitHubDalImp!
    var db: Connection!
    
    func initDb() {
        do {
            //create db and tables if not exist
            let dbPath = documentDirectoryURL.absoluteString + "db.sqlite3"
            db = try Connection(dbPath)
            
            gitHubDal = GitHubDalImp(db: db)
            
        } catch {
            log("initDb err")
        }
    }
    
    //service layer is responsible for specifying the thread task runs on
    func writeTaskOnDBQueue(_ async: Bool, task: @escaping () -> Void) {
        if async {
            dbQueue.async(execute: task)
        } else {
            task()
        }
    }
    
    //we may run query after certain write task is finished
    func asyncTaskOnDBQueue(task: @escaping () -> Void) {
        dbQueue.async(execute: task)
    }
}
