//
//  StringEx.swift
//  TrimData
//
//  Created by gao feng on 16/2/24.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit

extension String {
    func pp_toDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                return json
            } catch {
                print("convert err")
            }
        }
        return nil
    }
}
