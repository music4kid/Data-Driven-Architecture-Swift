//
//  FeedCellGitHubRepo.swift
//  TrimData
//
//  Created by gao feng on 16/2/25.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

class FeedCellGitHubRepo: FeedCell {

    var lbName = UILabel()
    var lbOpenIssue = UILabel()
    var lbStar = UILabel()
    var lbFork = UILabel()
    
    override class func fillCellData(feedItem: FeedItem) {
        feedItem.displayHeight = 80
    }
    
    
    required internal init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUIElements()
        layoutUIElements()
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initUIElements() {
        lbName.textColor = UIColor.blackColor()
        lbName.backgroundColor = UIColor.clearColor()
        lbName.font = UIFont.boldSystemFontOfSize(14)
        lbName.textAlignment = NSTextAlignment.Left
        contentView.addSubview(lbName)
        
     
        lbOpenIssue.textColor = UIColor.blackColor()
        lbOpenIssue.backgroundColor = UIColor.clearColor()
        lbOpenIssue.font = UIFont.systemFontOfSize(14)
        lbOpenIssue.textAlignment = NSTextAlignment.Left
        contentView.addSubview(lbOpenIssue)
        
        
        lbStar.textColor = UIColor.blackColor()
        lbStar.backgroundColor = UIColor.clearColor()
        lbStar.font = UIFont.systemFontOfSize(14)
        lbStar.textAlignment = NSTextAlignment.Left
        contentView.addSubview(lbStar)
        
        
        lbFork.textColor = UIColor.blackColor()
        lbFork.backgroundColor = UIColor.clearColor()
        lbFork.font = UIFont.systemFontOfSize(14)
        lbFork.textAlignment = NSTextAlignment.Left
        contentView.addSubview(lbFork)
    }
    
    func layoutUIElements() {
        let marginX = 20.0
        let marginY = 4.0
        
        lbName.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(marginY)
            make.left.equalTo(marginX);
            make.width.equalTo(contentView)
            make.height.equalTo(15)
        }
        
        lbOpenIssue.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(lbName.snp_bottom).offset(4)
            make.left.equalTo(lbName);
            make.height.equalTo(15)
        }
        
        lbStar.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(lbOpenIssue.snp_bottom).offset(4)
            make.left.equalTo(lbName);
            make.height.equalTo(15)
        }
        
        lbFork.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(lbStar.snp_bottom).offset(4)
            make.left.equalTo(lbName);
            make.height.equalTo(15)
        }
    }
    
    //data binding only, no custom logic
    override func configCellWithItem(item: FeedItem) {
        
        if let repo = item as? FeedItemGitHubRepo {
        
            //let's bind property
            bindUIProperty(&repo.repoName, lbName, true, handler: { (nV: String) -> () in
                self.lbName.text = nV
                self.lbName.sizeToFit()
            })
            
            bindUIProperty(&repo.repoOpenIssue, lbOpenIssue, true, handler: { (nV: String) -> () in
                self.lbOpenIssue.text = nV
                self.lbOpenIssue.sizeToFit()
            })
            
            bindUIProperty(&repo.repoStar, lbStar, true, handler: { (nV: String) -> () in
                self.lbStar.text = nV
                self.lbStar.sizeToFit()
            })

            bindUIProperty(&repo.repoFork, lbFork, true, handler: { (nV: String) -> () in
                self.lbFork.text = nV
                self.lbFork.sizeToFit()
            })
        }
    }
    
    deinit {
        
    }

  }
