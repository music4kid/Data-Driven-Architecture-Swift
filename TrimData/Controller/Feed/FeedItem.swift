//
//  FeedItem.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

public enum FeedItemType: Int {
    case feedItemNormal = 0
    case feedItemGitHubRepo = 1
    case feedItemUnknown = 1000
    
    var str: String {
        switch self {
        case .feedItemNormal:
            return "feedItemNormal"
        case .feedItemGitHubRepo:
            return "feedItemGitHubRepo"
        case .feedItemUnknown:
            return "feedItemUnknown"
        }
    }
}

public class FeedItem {
    var itemType: FeedItemType!
    var itemId: String?
    
    var displayHeight: CGFloat = 0
    
    init(aType: FeedItemType = .feedItemUnknown) {
        itemType = aType
    }
}
