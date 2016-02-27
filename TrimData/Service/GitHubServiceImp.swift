//
//  GitHubServiceImp.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Alamofire
import Observable

class GitHubServiceImp: NSObject, GitHubServiceProtocol {
    
    let keyGitHubAccountName = "keyGitHubAccountName"
    let keyGitHubAccountPwd = "keyGitHubAccountPwd"
    
    func loadRepositories() -> [GitHubRepository] {
        return _DAL.gitHubDal.loadAllRepos()
    }
    
    func loadRepositoriesFromServer() {
        GitHubRepositoryRequest().getGitHubRepositories()
    }
    
    
    //MARK: account logic
    func isGitHubAccountSet() -> Bool {
        var set = false
        
        set = (githubAccountName != nil)
        
        return set
    }
    
    var githubAccountName: String? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey(keyGitHubAccountName) as? String
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: keyGitHubAccountName)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    var githubAccountPwd: String? {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey(keyGitHubAccountPwd) as? String
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: keyGitHubAccountPwd)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    //MARK: models logic
    func updateOrInsertGitHubRepository(repo: GitHubRepository) {
        if let eRepo = _Service.githubService.getGitHubRepositoryById(repo.id^) {
            //update, trigger update event
            eRepo.name ^= repo.name^
            eRepo.star ^= repo.star^
            eRepo.fork ^= repo.fork^
            eRepo.openIssue ^= repo.openIssue^
            
            _Event.githubEvent.update.notify(eRepo)
            
            //save to db
            _DAL.writeTaskOnDBQueue(true, task: { () -> () in
                _DAL.gitHubDal.saveRepo(repo)
            })
            
        }
        else {
            //insert, trigger insert event
            _Event.githubEvent.insert.notify(repo)
            
            //save to db
            _DAL.writeTaskOnDBQueue(true, task: { () -> () in
                _DAL.gitHubDal.saveRepo(repo)
            })
        }
    }
    
    func getGitHubRepositoryById(id: String) -> GitHubRepository? {
        //try get from db
        return _DAL.gitHubDal.getRepo(id)
    }
    
}
