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
import EZSwiftExtensions

enum JenkinsMethod {
    case Login, Build
}

enum JenkinsError: ErrorType {
    case ParaInvalid
    case NetError
    case NetApiError
}

var jenkinsNetRequest = JenkinsNetRequest()

class JenkinsNetRequest: NSObject {
    
    var serverAddr: String?
    
    /*!
    登录请求
    
    - parameter para: user, pwd
    */
    private func loginReq(para: [String: AnyObject], componentHandle: (Result<AnyObject, JenkinsError> -> Void)) {
        
        guard let user = para["user"] as? String else {
            componentHandle(.Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        guard let pwd = para["pwd"] as? String  else {
            componentHandle(.Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        guard let serverNetAddr = serverAddr else {
            componentHandle(.Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        if serverNetAddr.lowercaseString.contains("http") == false {
            componentHandle(.Failure(.ParaInvalid))
            Log.error("Para Invalid")
            return
        }
        
        var parameters: [String: String]? = nil
        var serverRequestAddr = serverNetAddr
        
        if user != "" {
            
            parameters = ["from" : "/api/json?pretty=true", "j_username" : user, "j_password" : pwd]
            serverRequestAddr += "/j_acegi_security_check"
            
        } else {
            serverRequestAddr += "/api/json?pretty=true"
        }
        
        Alamofire.request(.POST, serverRequestAddr, parameters: parameters).responseObject { (response: Response<LoginResponse, NSError>) -> Void in
            if response.result.isFailure {
                componentHandle(.Failure(.NetError))
                Log.error("Network Invalid")
                return
            }
            
            guard let loginResponse = response.result.value else {
                componentHandle(.Failure(.NetApiError))
                Log.error("Network Api Error")
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                componentHandle(.Success(loginResponse))
                
            })
            
        }
    }
    
    /**
     启动编译
     
     - parameter jobName: 工程名称
     */
    private func buildJob(para: [String: AnyObject], componentHandle: (Result<AnyObject, JenkinsError> -> Void)) {
        
        guard let serverNetAddr = serverAddr else {
            Log.error("Server address is nil")
            componentHandle(.Failure(.ParaInvalid))
            return
        }
        
        guard let jobName = para["jobName"] as? String else {
            Log.error("Job name is nil")
            componentHandle(.Failure(.ParaInvalid))
            return
        }
        
        let apiUrl = serverNetAddr + "/job/" + jobName + "/build"
        
        Alamofire.request(.POST, apiUrl).responseData { (response) -> Void in
            if response.result.isFailure {
                Log.error("Build failure")
                componentHandle(.Failure(.ParaInvalid))
                return
            }
            
            componentHandle(.Success(""))
            Log.info("Build Sussess")
        }
        
    }
    

    
    /*!
    Post请求
    
    - parameter method: 操作方法
    - parameter para:   返回结果
    */
    func httpPost(method: JenkinsMethod, para: [String: AnyObject], componentHandle: Result<AnyObject, JenkinsError> -> Void) {
        
        switch method {
            
        case .Login:
            loginReq(para, componentHandle: componentHandle)
            
        case .Build:
            buildJob(para, componentHandle: componentHandle)
            

        }
        
    }
    
}
