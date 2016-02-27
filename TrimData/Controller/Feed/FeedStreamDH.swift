//
//  FeedStreamDataHandler.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

class FeedStreamDH: CDD.DataHandler, FeedStreamDHProtocol {
    
    private var feedItems = [FeedItem]()
    private var feedItemEvent = CDDDataEventSource<FeedItem>()
    
    override init() {
        super.init()
        
        feedItems = [FeedItem]()
    }

    func getFeedItemDataEvent() -> CDDDataEventSource<FeedItem> {
        return feedItemEvent
    }
    
    func getFeedItems() -> [FeedItem] {
        return feedItems
    }
    
    func setFeedItems(items: [FeedItem]) {
        for item: FeedItem in items {
            FeedCell.calculateCellData(item)
        }
        
        feedItems = items
        
        //trigger refresh
        if feedItems.count > 0 {
            feedItemEvent.refresh.notify(feedItems.first!)
        }
    }
    
    func insertNewFeedItem(item: FeedItem) {
        FeedCell.calculateCellData(item)
        feedItems.append(item)
        
        //trigger refresh or insert
        feedItemEvent.refresh.notify(item)
    }
    
    
}
