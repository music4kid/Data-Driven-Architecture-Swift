//
//  AppInitializer.swift
//  TrimData
//
//  Created by gao feng on 16/2/27.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

let _AppInitializer = AppInitializer.sharedInstance

class AppInitializer: NSObject {
    static let sharedInstance = AppInitializer()
    
    func initEnv() {
        _Service.initService()
        _Service.initDB()
    }
}
