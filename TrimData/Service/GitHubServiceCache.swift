//
//  GitHubServiceCache.swift
//  TrimData
//
//  Created by gao feng on 16/2/24.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

class GitHubServiceCache: GitHubServiceImp {
    
    private var cachedRepos = [String: GitHubRepository]()
    private var sema_repos = DispatchSemaphore(value: 1)
    
    //MARK: models logic
    override func loadRepositories() -> [GitHubRepository] {
        let repos = super.loadRepositories()
        
        _ = sema_repos.wait(timeout: .distantFuture)
        for repo in repos {
            cachedRepos[repo.id^] = repo
        }
        sema_repos.signal()
        
        return repos
    }
    
    override func getGitHubRepositoryById(_ id: String) -> GitHubRepository? {
        var repo: GitHubRepository?
        
        _ = sema_repos.wait(timeout: .distantFuture)
        repo = cachedRepos[id]
        sema_repos.signal()
        
        if repo != nil {
            return repo
        }
        else {
            let dbRepo = super.getGitHubRepositoryById(id)
            if dbRepo != nil {
                _ = sema_repos.wait(timeout: .distantFuture)
                cachedRepos[dbRepo!.id^] = dbRepo!
                sema_repos.signal()
            }
            return dbRepo
        }
    }
    
    override func updateOrInsertGitHubRepository(_ repo: GitHubRepository) {
        super.updateOrInsertGitHubRepository(repo)
       
        _ = sema_repos.wait(timeout: .distantFuture)
        if cachedRepos[repo.id^] == nil {
            cachedRepos[repo.id^] = repo
        }
        sema_repos.signal()
    }

    
    
}
