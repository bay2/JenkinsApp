//
//  LoginRequest.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/7.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import UIKit
import Alamofire

class JenkinsNetRequest: NSObject {
    
    var serverAddr: String?

    func loginReq(user: String, pwd: String) {
        
        guard let serverNetAddr = serverAddr else {
            return
        }
        
        if serverNetAddr.lowercaseString.contains("http") == false {
            return
        }
        
        
        Alamofire.request(.POST, serverNetAddr + "/j_acegi_security_check", parameters: ["j_username" : user, "j_password" : pwd, "from" : "/api/json?pretty=true"]).responseJSON { (response) -> Void in
            
            print("\(response)")
            
        }
        
    }
    
}
