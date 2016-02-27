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
    private var sema_repos = dispatch_semaphore_create(1)
    
    //MARK: models logic
    override func loadRepositories() -> [GitHubRepository] {
        let repos = super.loadRepositories()
        
        dispatch_semaphore_wait(sema_repos, DISPATCH_TIME_FOREVER)
        for repo in repos {
            cachedRepos[repo.id^] = repo
        }
        dispatch_semaphore_signal(sema_repos)
        
        return repos
    }
    
    override func getGitHubRepositoryById(id: String) -> GitHubRepository? {
        var repo: GitHubRepository?
        
        dispatch_semaphore_wait(sema_repos, DISPATCH_TIME_FOREVER)
        repo = cachedRepos[id]
        dispatch_semaphore_signal(sema_repos)
        
        if repo != nil {
            return repo
        }
        else {
            let dbRepo = super.getGitHubRepositoryById(id)
            if dbRepo != nil {
                dispatch_semaphore_wait(sema_repos, DISPATCH_TIME_FOREVER)
                cachedRepos[dbRepo!.id^] = dbRepo!
                dispatch_semaphore_signal(sema_repos)
            }
            return dbRepo
        }
    }
    
    override func updateOrInsertGitHubRepository(repo: GitHubRepository) {
        super.updateOrInsertGitHubRepository(repo)
       
        dispatch_semaphore_wait(sema_repos, DISPATCH_TIME_FOREVER)
        if cachedRepos[repo.id^] == nil {
            cachedRepos[repo.id^] = repo
        }
        dispatch_semaphore_signal(sema_repos)
    }

    
    
}
