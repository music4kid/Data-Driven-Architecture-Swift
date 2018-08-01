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
    func saveRepo(_ repo: GitHubRepository)
    func deleteRepo(_ repo: GitHubRepository)
    func getRepo(_ id: String) -> GitHubRepository?
    func deleteAllRepos()
    
}
