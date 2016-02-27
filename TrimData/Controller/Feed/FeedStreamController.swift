//
//  FeedStreamController.swift
//  TrimData
//
//  Created by gao feng on 16/2/22.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

class FeedStreamController: TDViewController, FeedStreamBODelegate {
   
    private var holder: FeedStreamView!
    private var bo: FeedStreamBO!
    private var dh: FeedStreamDH!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feed"
        
        holder = FeedStreamView(frame: view.frame)
        view = holder
        
        bo = FeedStreamBO(bc:self)
        bo.boDelegate = self
        dh = FeedStreamDH()
        
        context = CDD.Context(handler: dh!, bo: bo!)
        holder.context = context
        
        
        FeedCell.prepareFeedCell()
        bo.loadFeeds()
        holder.initFeedView()
        
        holder.setProgressVisible(true)
        bo.loadFeedsFromServer()
    }

   
    func stopLoadingUI() {
        holder.setProgressVisible(false)
        holder.hideRefresh()
    }
}
