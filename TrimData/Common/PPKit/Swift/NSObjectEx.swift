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
func objectHashString(_ obj: Any) -> String {
    return String(ObjectIdentifier(obj as AnyObject).hashValue)
}

extension NSObject {
    class func classFromString(_ className: String) -> AnyClass! {
        let className = Bundle.main.infoDictionary!["CFBundleName"] as! String + "." + className
        let aClass = NSClassFromString(className) as! NSObject.Type
        return aClass
    }

}
