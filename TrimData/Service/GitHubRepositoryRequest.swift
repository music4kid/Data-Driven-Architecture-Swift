//
//  GitHubRepositoryRequest.swift
//  TrimData
//
//  Created by gao feng on 16/2/24.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Alamofire
import Observable

class GitHubRepositoryRequest: GitHubRequest {
    func getGitHubRepositories() {
        let githubAccountName = _Service.githubService.githubAccountName
        let repositoryUrl = "https://\(gitHubBaseUrl)" + "/users/\(githubAccountName!)/repos"
        
        Alamofire.request(.GET, repositoryUrl.URLString)
            .responseJSON { response in
                
                if let err = response.result.error {
                    print(err)
                    //notify application layer
                }
                else {
                    if let arr = response.result.value as? [NSDictionary] {

                        for dic: NSDictionary in arr {
                            
                            let id = String((dic["id"] as! NSNumber).longLongValue)
                            let name = (dic["full_name"] as! String)
                            let star = (dic["stargazers_count"] as! NSNumber).longLongValue
                            let fork = (dic["forks_count"] as! NSNumber).longLongValue
                            let openIssue = (dic["open_issues_count"] as! NSNumber).longLongValue
                            
                            let repo = GitHubRepository(id: id, name: name, star: star, fork: fork, open: openIssue)
                            
                            _Service.githubService.updateOrInsertGitHubRepository(repo)
                        }
                    }
                }
                
        }
    }
    
}
