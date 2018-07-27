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
var sema_binding = DispatchSemaphore(value: 1)
func bindUIProperty <T> (_ prop: inout Observable<T>, _ target: NSObject, _ triggerNow: Bool, handler: @escaping (T) -> Void) {
    
    //remove old handler
    sema_binding.wait(timeout: .distantFuture)
    if let eSub = (bindingMap[objectHashString(target)] as? EventSubscription<ValueChange<Observable<T>.ValueType>>) {
        prop -= eSub
    }
    sema_binding.signal()
    
    //bind new handler
    if triggerNow {
        handler(prop^)
    }
    let sub = (prop += { (oV, nV) in
        handler(nV)
    })
    
    //if target is destroyed, remove subscription too
    sub.addOwnedObject(target)
    
    sema_binding.wait(timeout: .distantFuture)
    bindingMap[objectHashString(target)] = sub
    sema_binding.signal()
}


func bindProperty <T> (_ prop: inout Observable<T>, _ owner: AnyObject,  handler: @escaping (T) -> ()) {
    handler(prop^)
    
    let sub = (prop += { (oV, nV) in
        handler(nV)
    })
    
    sub.addOwnedObject(owner)
}

class ObservableUI: NSObject {
    
}
