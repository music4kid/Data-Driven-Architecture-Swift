//
//  GitHubDalImp.swift
//  TrimData
//
//  Created by gao feng on 16/2/26.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
//import Observable
import SQLite

class GitHubDalImp: DALImpBase, GitHubDalProtocol {
    
    var tableRepo: Table!
    let repo_id = Expression<String>("id")
    let repo_name = Expression<String>("name")
    let repo_star = Expression<Int>("star")
    let repo_fork = Expression<Int>("fork")
    let repo_openIssue = Expression<Int>("openIssue")
    
    override init(db: Connection) {
        super.init(db: db)
        do {
            tableRepo = Table("repo")
            //create repo
            try db.run(tableRepo.create(ifNotExists: true) { t in
                t.column(repo_id, primaryKey: true)
                t.column(repo_name)
                t.column(repo_star)
                t.column(repo_fork)
                t.column(repo_openIssue)
                })
        } catch {
            log("init github dal err")
        }
        
    }
    
    func loadAllRepos() -> [GitHubRepository] {
        var repos = [GitHubRepository]()
        
        do {
            for row in try db.prepare(tableRepo) {
                let repoId = row[repo_id]
                let repoName = row[repo_name]
                let repoStar = row[repo_star]
                let repoFork = row[repo_fork]
                let repoOpenIssue = row[repo_openIssue]
                let repo = GitHubRepository(id: repoId, name: repoName, star: repoStar, fork: repoFork, open: repoOpenIssue)
                
                repos.append(repo)
            }
        } catch {
            log("loadAllRepos err")
        }
        
        return repos
    }
    
    func saveRepo(_ repo: GitHubRepository) {
        do {
            if getRepo(repo.id~) != nil {
                try db.run(tableRepo.filter(repo_id == repo.id~).update(
                    repo_name <- repo.name~,
                    repo_star <- repo.star~,
                    repo_fork <- repo.fork~,
                    repo_openIssue <- repo.openIssue~
                    ))
                
                _Event.githubEvent.update.notify(repo)
            }
            else {
                try db.run(tableRepo.insert(
                    repo_id <- repo.id~,
                    repo_name <- repo.name~,
                    repo_star <- repo.star~,
                    repo_fork <- repo.fork~,
                    repo_openIssue <- repo.openIssue~
                    ))
                
                _Event.githubEvent.insert.notify(repo)
            }
        } catch {
            log("saveRepo err")
        }
    }
    
    func deleteRepo(repo: GitHubRepository) {
        
    }
    
    func getRepo(_ id: String) -> GitHubRepository? {
        var repo: GitHubRepository? = nil
        
        if let row = db.pluck(tableRepo.filter(repo_id == id)) {
            let repoId = row[repo_id]
            let repoName = row[repo_name]
            let repoStar = row[repo_star]
            let repoFork = row[repo_fork]
            let repoOpenIssue = row[repo_openIssue]
            repo = GitHubRepository(id: repoId, name: repoName, star: repoStar, fork: repoFork, open: repoOpenIssue)
        }
        
        return repo
    }
    
    func deleteAllRepos() {
        
    }
}
