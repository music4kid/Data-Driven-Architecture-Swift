//
//  FeedStreamBO.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

//business object still needs some help from its controller
protocol FeedStreamBODelegate {
    func stopLoadingUI()
}

class FeedStreamBO: CDD.BusinessObject, FeedStreamBOProtocol {
    
    var boDelegate: FeedStreamBODelegate?
    
    override init(bc: UIViewController) {
        super.init(bc: bc)
        
        //observe data events
        _Event.register(self, event: _Event.githubEvent.insert) { (repo: GitHubRepository) -> () in
            let repoItem = FeedItemGitHubRepo(repo: repo)
            let dataHandler = self.weakContext!.dataHandler as! FeedStreamDH
            dataHandler.insertNewFeedItem(repoItem)
        }
        
        _Event.register(self, event: _Event.githubEvent.update) { (repo: GitHubRepository) -> () in
           //feed item update is triggered by property observer, stop loading UI only
            self.boDelegate?.stopLoadingUI()
            
            //if no property binding implemented, custom property assignment is required
        }
    }
    
    deinit {
        _Event.unregisterAll(self)
    }
    
    //load all feeds from memory or disk
    func loadFeeds() {
        var items = [FeedItem]()
        
        //load github repo
        let repos = _Service.githubService.loadRepositories()
        for repo in repos {
            let repoItem = FeedItemGitHubRepo(repo: repo)
            items.append(repoItem)
        }
        
        let dataHandler = self.weakContext!.dataHandler as! FeedStreamDH
        
        dataHandler.setFeedItems(items)
    }
    
    //load all feeds from server
    func loadFeedsFromServer() {
        
        //test
        _Service.githubService.githubAccountName = "music4kid"
        
        _Service.feedStreamService.loadFeedItemsFromServer()
    }
}
