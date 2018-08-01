//
//  GitHubAccountRequest.swift
//  TrimData
//
//  Created by gao feng on 16/2/24.
//  Copyright © 2016年 gao feng. All rights reserved.
//

import UIKit
import Alamofire

class GitHubAccountRequest: GitHubRequest {
    func getGitHubAccountDetail(username: String) {
        let accountUrl = "https://\(gitHubBaseUrl)" + "/users/\(username)"
        
        Alamofire.request(accountUrl).responseJSON { response in
                if let err = response.result.error {
                    print(err)
                    //notify application layer
                }
                else {
                    if let jsonValue = response.result.value as? String{
                        let dict: [String: Any]? = jsonValue.pp_toDictionary()
                        if dict != nil {
                            
                        }
                    }
                }
                
        }
    }
}
