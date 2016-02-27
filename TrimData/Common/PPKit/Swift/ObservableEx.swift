

//
//  ObservableEx.swift
//  TrimData
//
//  Created by gao feng on 16/2/25.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import Observable

//solve possible operator conflict
postfix operator ~ { }
public postfix func ~ <T : AnyObservable> (x: T) -> T.ValueType {
    return x.value
}

// event += { new in ... }
public func += <T> (event: EventReference<T>, handler: T -> ()) -> EventSubscription<T> {
    return event.add({
        let d = $0
        //data event is handled by UI layer most of the time, run handler on main thread for thread safty
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            handler(d)
        })
    })
}
// event -= sub
public func -= <T> (event: EventReference<T>, sub: EventSubscription<T>) {
    event.remove(sub)
}

public class ObservableEx {
    var sema_event = dispatch_semaphore_create(1)
    var subscriptionMap = [NSString: [AnyObject]]()
    
    func register <T> (target: AnyObject, event: EventReference<T>, handler: T -> ()) {
        let sub = (event += handler)
        
        dispatch_semaphore_wait(sema_event, DISPATCH_TIME_FOREVER)
        if var existingSubs = subscriptionMap[objectHashString(target)] {
            existingSubs.append(sub)
        }
        else {
            let subs = [sub]
            subscriptionMap[objectHashString(target)] = subs
        }
        dispatch_semaphore_signal(sema_event)
    }
    
    func unregisterAll(target: AnyObject) {
        
        dispatch_semaphore_wait(sema_event, DISPATCH_TIME_FOREVER)
        if var existingSubs = subscriptionMap[objectHashString(target)] {
            for obj: AnyObject in existingSubs {
                let sub = obj as! EventSubscription<AnyClass>
                sub.invalidate()
            }
            existingSubs.removeAll()
        }
        dispatch_semaphore_signal(sema_event)
    }
}


