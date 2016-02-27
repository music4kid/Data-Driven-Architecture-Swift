//
//  FeedStreamServiceImp.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

class FeedStreamServiceImp: NSObject, FeedStreamServiceProtocol {
    
    
    func loadFeedItemsFromServer() {
        //load github items
        _Service.githubService.loadRepositoriesFromServer()
        
        
    }
}
