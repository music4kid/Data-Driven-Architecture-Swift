//
//  SecondViewController.swift
//  TrimData
//
//  Created by gao feng on 16/2/21.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

class SecondViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let setting: SettingListController = SettingListController()
        pushViewController(setting, animated: false)
    }
    
}

