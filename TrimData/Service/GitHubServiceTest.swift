//
//  GitHubServiceTest.swift
//  TrimData
//
//  Created by gao feng on 16/2/28.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

class GitHubServiceTest: GitHubServiceCache {
    
    override func loadRepositories() -> [GitHubRepository] {
        var repos: [GitHubRepository]?
        
        measure { () -> () in
            repos = super.loadRepositories()
        }
        
        return repos!
    }
    
}
