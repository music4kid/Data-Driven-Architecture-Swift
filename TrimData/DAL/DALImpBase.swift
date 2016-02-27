//
//  DALImpBase.swift
//  TrimData
//
//  Created by gao feng on 16/2/26.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import SQLite

class DALImpBase: NSObject {
    var db: Connection
    
    init(db: Connection) {
        self.db = db
    }
}
