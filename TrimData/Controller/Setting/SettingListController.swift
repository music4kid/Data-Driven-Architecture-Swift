//
//  SettingListController.swift
//  TrimData
//
//  Created by gao feng on 16/2/22.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

class SettingListController: TDViewController {
    
    let holderView: SettingListView = {
        let holderView = SettingListView(frame: UIScreen.main.bounds)
        return holderView
    }()
    
    override func loadView() {
        view = holderView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Setting"
    }

    

}
