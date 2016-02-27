//
//  GitHubDalProtocol.swift
//  TrimData
//
//  Created by gao feng on 16/2/26.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

protocol GitHubDalProtocol {
    func loadAllRepos() -> [GitHubRepository]
    func saveRepo(repo: GitHubRepository)
    func deleteRepo(repo: GitHubRepository)
    func getRepo(id: String) -> GitHubRepository?
    func deleteAllRepos()
    
}