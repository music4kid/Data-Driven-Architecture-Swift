//
//  Object.swift
//  TrimData
//
//  Created by gao feng on 16/2/21.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

extension NSObject{
    
    private struct AssociatedKeys {
        static var ContextKey = "NSObject.Context"
    }
    
    var context: CDD.Context? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ContextKey) as? CDD.Context
        }
        set (context) {
            objc_setAssociatedObject(self, &AssociatedKeys.ContextKey, context, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

