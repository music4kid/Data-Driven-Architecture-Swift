//
//  UIView.swift
//  TrimData
//
//  Created by gao feng on 16/2/21.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

extension UIView {
    
    private struct Static {
        static var token: dispatch_once_t = 0
    }
    
    public static func prepareUIViewForCDD() {
        dispatch_once(&Static.token) { () -> Void in
            let originalSelector = Selector("didAddSubview:")
            let swizzledSelector = Selector("newDidAddSubview:")
            
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    public func newDidAddSubview(subview: UIView) {
        newDidAddSubview(subview)
        
        measure { () -> () in
            self.buildViewContextFromSuper(subview)
        }
    }
    
    private func buildViewContextFromSuper(view: UIView?) {
        if view!.context == nil {
            var sprView: UIView? = view!.superview
            while sprView != nil {
                if sprView!.context != nil {
                    view?.context = sprView?.context
                    buildViewContextForChildren(view)
                }
                
                sprView = sprView!.superview
            }
        }
    }
    
    private func buildViewContextForChildren(view: UIView?) {
        for subview: UIView in (view?.subviews)! {
            if subview.context != nil {
                subview.context = self.context
                buildViewContextForChildren(subview)
            }
        }
    }
}


