//
//  GitHubRepository.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

class GitHubRepository {
    var id: Observable<String>
    var name: Observable<String>
    var star: Observable<Int>
    var fork: Observable<Int>
    var openIssue: Observable<Int>
    
    init(id: String, name: String, star: Int, fork: Int, open: Int) {
        self.id = Observable(id)
        self.name = Observable(name)
        self.star = Observable(star)
        self.fork = Observable(fork)
        self.openIssue = Observable(open)
    }
}
