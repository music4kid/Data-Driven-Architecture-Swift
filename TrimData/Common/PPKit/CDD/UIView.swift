//
//  UIView.swift
//  TrimData
//
//  Created by gao feng on 16/2/21.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

extension UIView {
    
    private static let _onceToken = UUID().uuidString
    
    public static func prepareUIViewForCDD() {
        DispatchQueue.once(token: _onceToken) {
            
            let originalSelector = #selector(didAddSubview)
            let swizzledSelector = #selector(newDidAddSubview)
            
            guard let originalMethod = class_getInstanceMethod(self, originalSelector) else { return }
            guard let swizzledMethod = class_getInstanceMethod(self, swizzledSelector) else { return }
            
            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
            
            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }
    
    @objc public func newDidAddSubview(_ subview: UIView) {
        newDidAddSubview(subview)
        
        measure { () -> () in
            self.buildViewContextFromSuper(subview)
        }
    }
    
    private func buildViewContextFromSuper(_ view: UIView?) {
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
    
    private func buildViewContextForChildren(_ view: UIView?) {
        for subview: UIView in (view?.subviews)! {
            if subview.context != nil {
                subview.context = self.context
                buildViewContextForChildren(subview)
            }
        }
    }
}


