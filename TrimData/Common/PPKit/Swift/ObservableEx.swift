

//
//  ObservableEx.swift
//  TrimData
//
//  Created by gao feng on 16/2/25.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import Observable

//solve possible operator conflict
postfix operator ~
public postfix func ~ <T : AnyObservable> (x: T) -> T.ValueType {
    return x.value
}

// event += { new in ... }
public func += <T> (event: EventReference<T>, handler: @escaping (T) -> Void) -> EventSubscription<T> {
    return event.add {
        let d = $0
        //data event is handled by UI layer most of the time, run handler on main thread for thread safty
        DispatchQueue.main.async {
            handler(d)
        }
    }
}
// event -= sub
public func -= <T> (event: EventReference<T>, sub: EventSubscription<T>) {
    event.remove(sub)
}

public class ObservableEx {
    var sema_event = DispatchSemaphore(value: 1)
    var subscriptionMap = [String: [Any]]()
    
    func register <T> (_ target: Any, event: EventReference<T>, handler: @escaping (T) -> Void) {
        let sub = (event += handler)
        _ = sema_event.wait(timeout: .distantFuture)
        if var existingSubs = subscriptionMap[objectHashString(target)] {
            existingSubs.append(sub)
        }
        else {
            let subs = [sub]
            subscriptionMap[objectHashString(target)] = subs
        }
        sema_event.signal()
    }
    
    func unregisterAll(_ target: Any) {
        
        _ = sema_event.wait(timeout: .distantFuture)
        if var existingSubs = subscriptionMap[objectHashString(target)] {
            for obj in existingSubs {
                let sub = obj as! EventSubscription<AnyClass>
                sub.invalidate()
            }
            existingSubs.removeAll()
        }
        sema_event.signal()
    }
}


