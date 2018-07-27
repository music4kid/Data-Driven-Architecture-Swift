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
            return UserDefaults.standard.object(forKey: keyGitHubAccountName) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyGitHubAccountName)
            UserDefaults.standard.synchronize()
        }
    }
    var githubAccountPwd: String? {
        get {
            return UserDefaults.standard.object(forKey: keyGitHubAccountPwd) as? String
        }
        set {
            UserDefaults.standard.set(newValue, forKey: keyGitHubAccountPwd)
            UserDefaults.standard.synchronize()
        }
    }
    
    //MARK: models logic
    func updateOrInsertGitHubRepository(_ repo: GitHubRepository) {
        if let eRepo = _Service.githubService.getGitHubRepositoryById(repo.id^) {
            //property update
            eRepo.name ^= repo.name^
            eRepo.star ^= repo.star^
            eRepo.fork ^= repo.fork^
            eRepo.openIssue ^= repo.openIssue^
            
            //save to db
            _DAL.writeTaskOnDBQueue(true, task: { () -> () in
                _DAL.gitHubDal.saveRepo(repo)
            })
            
        }
        else {
           
            //save to db
            _DAL.writeTaskOnDBQueue(true, task: { () -> () in
                _DAL.gitHubDal.saveRepo(repo)
            })
        }
    }
    
    func getGitHubRepositoryById(_ id: String) -> GitHubRepository? {
        //try get from db
        return _DAL.gitHubDal.getRepo(id)
    }
    
}
