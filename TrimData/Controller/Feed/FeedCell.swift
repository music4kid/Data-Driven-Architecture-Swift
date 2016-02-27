//
//  FeedCell.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import SnapKit

class FeedCell: UITableViewCell {
    
    //MARK: Cell Preparation
    static var cellMap = [String: AnyClass]();
    
    //tmp hack, base class should know nothing about its subclass
    internal static func prepareFeedCell() {
        cellMap[String(FeedItemType.FeedItemNormal)] = FeedCellNormal.self
        cellMap[String(FeedItemType.FeedItemGitHubRepo)] = FeedCellGitHubRepo.self
    }
    
    internal static func getCellClassForItemType(itemType: FeedItemType) -> AnyClass? {
        return cellMap[String(itemType)]
    }
    
    //MARK: cell Util
    static func calculateCellData(feedItem: FeedItem) {
        let cellClass: AnyClass? = getCellClassForItemType(feedItem.itemType)
        assert(cellClass != nil, "cell not registered")
        
        (cellClass as! FeedCell.Type).fillCellData(feedItem)
    }
    class func fillCellData(feedItem: FeedItem) {
        
    }
    
    
    var bottomLine: UILabel? = nil

    //MARK: Cell Init
    required override internal init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        if bottomLine == nil {
            bottomLine = UILabel()
            bottomLine?.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
            self.contentView.addSubview(bottomLine!)
            bottomLine?.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(0)
                make.bottom.equalTo(self.contentView)
                make.width.equalTo(self.contentView)
                make.height.equalTo(0.5)
            })
        }
    }

    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func configCellWithItem(item: FeedItem) {
        
    }
}
