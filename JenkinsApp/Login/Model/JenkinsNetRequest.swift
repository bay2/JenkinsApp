//
//  LoginRequest.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/7.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import UIKit
import Alamofire
import Log

enum JenkinsMethod {
    case Login
}

enum JenkinsError: ErrorType {
    case ParaInvalid
    case NetError
    case NetApiError
}

class JenkinsNetRequest: NSObject {
    

    
    typealias PostNotificationType = (JenkinsMethod, Result<AnyObject, JenkinsError>) -> Void
    
    var postNotification: PostNotificationType?
    
    var serverAddr: String?
    

    /*!
    登录请求
    
    - parameter para: user, pwd
    */
    private func loginReq(para: [String: AnyObject]) {
        
        guard let user = para["user"] else {
            cellPostNotification(.Login, result: .Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        guard let pwd = para["pwd"] else {
            cellPostNotification(.Login, result: .Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        guard let serverNetAddr = serverAddr else {
            cellPostNotification(.Login, result: .Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        if serverNetAddr.lowercaseString.contains("http") == false {
            cellPostNotification(.Login, result: .Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        Alamofire.request(.POST, serverNetAddr + "/j_acegi_security_check", parameters: ["j_username" : user, "j_password" : pwd, "from" : "/api/json?pretty=true"]).responseJSON { (response) -> Void in
            
            if response.result.isFailure {
                self.cellPostNotification(.Login, result: .Failure(.NetError))
                Log.error("Network Invalid")
                return
            }
            
            guard let loginResponse = response.result.value else {
                self.cellPostNotification(.Login, result: .Failure(.NetApiError))
                Log.error("Network Api Error")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                self.cellPostNotification(.Login, result: .Success(loginResponse))
                
            })
            
        }
    }
    
    /*!
    回调处理函数
    
    - parameter method: 操作方法
    - parameter result: 返回结果
    */
    func cellPostNotification(method: JenkinsMethod, result: Result<AnyObject, JenkinsError>) {
        
        if postNotification == nil {
            return
        }
        
        postNotification!(method, result)
        
    }
    
    func addPostNotification(postNotification: PostNotificationType) {
        
    }

    
    /*!
    Post请求
    
    - parameter method: 操作方法
    - parameter para:   返回结果
    */
    func httpPost(method: JenkinsMethod, para: [String: AnyObject]) {
        
        switch method {
            
        case .Login:
            loginReq(para)
            
        }
        
    }
    
}
