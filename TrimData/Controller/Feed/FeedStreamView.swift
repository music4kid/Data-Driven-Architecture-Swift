//
//  FeedStreamView.swift
//  TrimData
//
//  Created by gao feng on 16/2/22.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import PKHUD

class FeedStreamView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var refreshCtrl: UIRefreshControl!

    override init(frame: CGRect) {
        super.init(frame: frame);
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    internal func initFeedView() {
        backgroundColor = UIColor.whiteColor()
        
        PKHUD.sharedHUD.dimsBackground = false
    
        //init tableview
        tableView = UITableView(frame: frame)
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        //init pull refresh
        refreshCtrl = UIRefreshControl()
        refreshCtrl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshCtrl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshCtrl)
        
        //bind data event 
        let dh = context?.dataHandler as! FeedStreamDHProtocol
        
        dh.getFeedItemDataEvent().register(self, event: dh.getFeedItemDataEvent().refresh) { (item: FeedItem) -> () in
            self.tableView.reloadData()

            self.hideRefresh()
            self.setProgressVisible(false)
        }
    }
 
    //MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dh = context?.dataHandler as! FeedStreamDHProtocol
        let feedItems = dh.getFeedItems()
        
        return feedItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dh = context?.dataHandler as! FeedStreamDHProtocol
        let feedItems = dh.getFeedItems()
        let item: FeedItem = feedItems[indexPath.row]
        
        let cellIdentifier = "feed_cellIdentifier_\(String(item.itemType))"
        let cellClass = FeedCell.getCellClassForItemType(item.itemType) as? FeedCell.Type
        
        assert(cellClass != nil, "no feed cell registered, err")
        
        
        var cell: FeedCell = cellClass!.init(style: .Default, reuseIdentifier: cellIdentifier)
        if let reuseCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            cell = reuseCell as! FeedCell
        }
        cell.selectionStyle = .None
      
        cell.configCellWithItem(item)
        
        return cell
    }
    
    //MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        let dh = context?.dataHandler as! FeedStreamDHProtocol
        let feedItems = dh.getFeedItems()
        if indexPath.row <= feedItems.count-1 {
            let item: FeedItem = feedItems[indexPath.row]
            height = item.displayHeight
        }
        
        return height
    }
    
    
    //MARK: Pull Refresh
    func refresh(sender:AnyObject){
        let bo = context?.businessObject as! FeedStreamBO
        bo.loadFeedsFromServer()
    }
    
    func hideRefresh() {
        refreshCtrl.endRefreshing()
    }
    
    //MARK: Progress Loading
    func setProgressVisible(visible:Bool) {
        if visible {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
        }
        else {
            PKHUD.sharedHUD.hide()
        }
    }
    
    deinit {
        let dh = context?.dataHandler as! FeedStreamDHProtocol
        dh.getFeedItemDataEvent().unregisterAll(self)
        
        print("FeedStream tableview deinit")
    }
    
}
