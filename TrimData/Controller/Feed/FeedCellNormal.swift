//
//  FeedCellNormal.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class FeedCellNormal: FeedCell {
    
    var lbName = UILabel()
    var imgAvatar = UIImageView()
    var lbDesc = UILabel()
    
    override class func fillCellData(feedItem: FeedItem) {
        feedItem.displayHeight = 100
    }


    required internal init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUIElements()
        layoutUIElements()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initUIElements()
        layoutUIElements()
    }
    
    func initUIElements() {
        lbName.textColor = UIColor.blackColor()
        lbName.backgroundColor = UIColor.clearColor()
        lbName.font = UIFont.systemFontOfSize(14)
        lbName.textAlignment = NSTextAlignment.Left
        contentView.addSubview(lbName)
        
        lbDesc.textColor = UIColor.blackColor()
        lbDesc.backgroundColor = UIColor.clearColor()
        lbDesc.font = UIFont.systemFontOfSize(14)
        lbDesc.textAlignment = NSTextAlignment.Left
        contentView.addSubview(lbDesc)
        
        imgAvatar.backgroundColor = UIColor.clearColor()
        contentView.addSubview(imgAvatar)
    }
    
    func layoutUIElements() {
        let marginX = 4.0
        let marginY = 4.0
        let avatarSize = 40
        
        imgAvatar.snp_makeConstraints { (make) -> Void in
            make.topMargin.equalTo(marginY)
            make.leftMargin.equalTo(marginX)
            make.size.equalTo(avatarSize)
        }
        
        lbName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(imgAvatar)
            make.left.equalTo(imgAvatar.snp_right).offset(4);
            make.width.equalTo(contentView)
            make.height.equalTo(15)
        }
        
        lbDesc.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(lbName.snp_bottom).offset(marginY)
            make.left.equalTo(lbName)
            make.width.equalTo(lbName)
            make.height.equalTo(15)
        }
    }
    
    override func configCellWithItem(item: FeedItem) {
        
        if let normalItem = item as? FeedItemNormal {
            lbName.text = normalItem.itemName
            
            lbDesc.text = normalItem.itemDesc
            
            imgAvatar.kf_setImageWithURL(NSURL(string: normalItem.itemAvatar!)!)
        }
        
        
    }
}
