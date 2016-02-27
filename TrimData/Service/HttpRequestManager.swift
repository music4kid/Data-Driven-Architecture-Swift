//
//  HttpRequestManager.swift
//  TrimData
//
//  Created by gao feng on 16/2/24.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

let _HTTPMgr = HttpRequestManager.sharedInstance

class HttpRequestManager: NSObject {
    static let sharedInstance = HttpRequestManager()
}
