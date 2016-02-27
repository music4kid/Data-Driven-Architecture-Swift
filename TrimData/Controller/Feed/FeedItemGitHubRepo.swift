//
//  FeedItemGitHubRepo.swift
//  TrimData
//
//  Created by gao feng on 16/2/25.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

class FeedItemGitHubRepo: FeedItem {
    var repoName = Observable<String>("")
    var repoStar = Observable<String>("")
    var repoFork = Observable<String>("")
    var repoOpenIssue = Observable<String>("")
    
    init(repo: GitHubRepository) {
        
        super.init(aType: .FeedItemGitHubRepo)
        
        //bind value, custom logic may apply
        bindProperty(&repo.name, self) { (nV: String) -> () in
            self.repoName <- nV
        }
        
        bindProperty(&repo.star, self) { (nV: Int64) -> () in
            self.repoStar <- "star: \(nV)"
        }
        
        bindProperty(&repo.fork, self) { (nV: Int64) -> () in
            self.repoFork <- "fork: \(nV)"
        }
        
        bindProperty(&repo.openIssue, self) { (nV: Int64) -> () in
            self.repoOpenIssue <- "open issue: \(nV)"
        }
    }
    
    deinit {
        
    }
}

