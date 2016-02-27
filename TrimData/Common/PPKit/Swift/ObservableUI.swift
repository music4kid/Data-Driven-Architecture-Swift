//
//  ObservableUI.swift
//  TrimData
//
//  Created by gao feng on 16/2/26.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

//be careful, this func has the side effect of adding a new handler
var bindingMap = [String: Any]()
var sema_binding = dispatch_semaphore_create(1)
func bindUIProperty <T> (inout prop: Observable<T>, _ target: NSObject, _ triggerNow: Bool, handler: (T) -> ()) {
    
    //remove old handler
    dispatch_semaphore_wait(sema_binding, DISPATCH_TIME_FOREVER)
    if let eSub = (bindingMap[objectHashString(target)] as? EventSubscription<ValueChange<Observable<T>.ValueType>>) {
        prop -= eSub
    }
    dispatch_semaphore_signal(sema_binding)
    
    //bind new handler
    if triggerNow {
        handler(prop^)
    }
    let sub = (prop += { (oV, nV) in
        handler(nV)
    })
    
    //if target is destroyed, remove subscription too
    sub.addOwnedObject(target)
    
    dispatch_semaphore_wait(sema_binding, DISPATCH_TIME_FOREVER)
    bindingMap[objectHashString(target)] = sub
    dispatch_semaphore_signal(sema_binding)
}


func bindProperty <T> (inout prop: Observable<T>, _ owner: AnyObject,  handler: (T) -> ()) {
    handler(prop^)
    
    let sub = (prop += { (oV, nV) in
        handler(nV)
    })
    
    sub.addOwnedObject(owner)
}

class ObservableUI: NSObject {
    
}
