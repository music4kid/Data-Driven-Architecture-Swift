//
//  DataEvent.swift
//  TrimData
//
//  Created by gao feng on 16/2/24.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

let _Event = EventSource.sharedInstance

class DataEvent<T>: NSObject {
    var insert = EventReference<T>()
    var delete = EventReference<T>()
    var update = EventReference<T>()
    var refresh = EventReference<T>()
}

class EventSource: ObservableEx {
    static var sharedInstance = EventSource()
    var githubEvent = DataEvent<GitHubRepository>()
    
}







