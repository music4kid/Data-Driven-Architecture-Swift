//
//  FeedItem.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

public enum FeedItemType: Int {
    case FeedItemNormal = 0
    case FeedItemGitHubRepo = 1
    case FeedItemUnknown = 1000
}

public class FeedItem {
    var itemType: FeedItemType!
    var itemId: String?
    
    var displayHeight: CGFloat = 0
    
    init(aType: FeedItemType = FeedItemType.FeedItemUnknown) {
        itemType = aType
    }
}
