//
//  Context.swift
//  TrimData
//
//  Created by gao feng on 16/2/21.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Observable

class CDDDataEventSource<T> : ObservableEx {
    var insert = EventReference<T>()
    var delete = EventReference<T>()
    var refresh = EventReference<T>()
}

public struct CDD {
    public class DataHandler {
        public weak var weakContext: CDD.Context?
        
    }
    
    public class BusinessObject {
        public var baseController: UIViewController
        public weak var weakContext: CDD.Context?
        
        init(bc: UIViewController) {
            baseController = bc
        }
    }
    
    public class Context {
        
        public let dataHandler: DataHandler
        public let businessObject: BusinessObject
        
        init(handler: DataHandler, bo: BusinessObject){
            dataHandler = handler
            businessObject = bo
            
            dataHandler.weakContext = self;
            businessObject.weakContext = self;
        }
        
        deinit {
            print("context deinit")
        }
        
        public static func enableCDDContext() {
            UIView.prepareUIViewForCDD()
        }
    }
    
   
}


