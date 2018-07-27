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
        
        Alamofire.request(repositoryUrl, method: .get).responseJSON { response in
                
                if let err = response.result.error {
                    print(err)
                    //notify application layer
                }
                else {
                    if let arr = response.result.value as? [NSDictionary] {

                        for dic: NSDictionary in arr {
                            
                            let id = dic["id"] as? String ?? ""
                            let name = dic["full_name"] as? String ?? ""
                            let star = dic["stargazers_count"] as? Int ?? 0
                            let fork = dic["forks_count"] as? Int ?? 0
                            let openIssue = dic["open_issues_count"] as? Int ?? 0
                            
                            let repo = GitHubRepository(id: id, name: name, star: star, fork: fork, open: openIssue)
                            
                            _Service.githubService.updateOrInsertGitHubRepository(repo)
                        }
                    }
                }
                
        }
    }
    
}
