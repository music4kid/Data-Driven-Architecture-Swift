//
//  LogEx.swift
//  TrimData
//
//  Created by gao feng on 16/2/26.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

func log(_ message: String) {
    let file: NSString = #file
    fprint("\(file.lastPathComponent): \(#function): \(#line): \(message) )")
}

func fprint(_ format: String, _ args: Any...) {
    #if DEBUG
    print(NSString(format: format, arguments: getVaList(args)))
    #endif
}

func measure(function: String = #function, _ f: ()->()) {
    let start = CACurrentMediaTime()
    f()
    let end = CACurrentMediaTime()
    fprint("executing time of %@: %.3fms", function, (end - start)*1000)
}
