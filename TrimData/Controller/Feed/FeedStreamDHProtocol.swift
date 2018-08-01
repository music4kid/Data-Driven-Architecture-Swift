//
//  FeedStreamDHProtocol.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

protocol FeedStreamDHProtocol {
    func getFeedItems() -> [FeedItem]
    func setFeedItems(_ items: [FeedItem])
    
    func insertNewFeedItem(_ item: FeedItem)
    
    func getFeedItemDataEvent() -> CDDDataEventSource<FeedItem>
}
