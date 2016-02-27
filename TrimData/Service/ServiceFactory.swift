//
//  ServiceFactory.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

let _Service = ServiceFactory.sharedInstance

class ServiceFactory: NSObject {
    
    static let sharedInstance = ServiceFactory()
    
    let feedStreamService = FeedStreamServiceImp()
    let githubService = GitHubServiceCache()
    
    func initService() {
    
    }
    
    func initDB() {
        _DAL.initDb()
    }
}
