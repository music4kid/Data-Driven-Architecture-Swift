//
//  GitHubServiceProtocol.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

protocol GitHubServiceProtocol {
    func loadRepositories() -> [GitHubRepository]
    func loadRepositoriesFromServer()
    
    func getGitHubRepositoryById(_ id: String) -> GitHubRepository?
    func updateOrInsertGitHubRepository(_ repo: GitHubRepository)
}
