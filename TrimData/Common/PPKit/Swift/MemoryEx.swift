//
//  MemoryEx.swift
//  TrimData
//
//  Created by gao feng on 16/2/26.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

func address(_ o: UnsafeRawPointer) -> Int {
    return Int(bitPattern: o)
}
