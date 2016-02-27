//
//  NSObjectEx.swift
//  TrimData
//
//  Created by gao feng on 16/2/23.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

//use address as hash value
func objectHashString(obj: AnyObject) -> String {
    return String(ObjectIdentifier(obj).uintValue)
}

extension NSObject {
    class func classFromString(className: String) -> AnyClass! {
        let className = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String + "." + className
        let aClass = NSClassFromString(className) as! NSObject.Type
        return aClass
    }

}