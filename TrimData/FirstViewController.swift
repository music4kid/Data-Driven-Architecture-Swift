//
//  FirstViewController.swift
//  TrimData
//
//  Created by gao feng on 16/2/21.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

class FirstViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let feed: FeedStreamController = FeedStreamController()
        pushViewController(feed, animated: false)
        
    }

   
}

