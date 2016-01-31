//
//  JenkinsJSON.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/10.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper

/// job
class JobResponse: Mappable {
    
    var statColor: String? {
        didSet {
            if statColor == nil {
                statColor = "aa"
            }
        }
    }
    var name: String?
    var url: String?
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        statColor <- map["color"]
        url <- map["url"]
    }
}

/// 登录消息返回结果
class LoginResponse: Mappable {
    
    var jobs: [JobResponse]?
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        
        jobs <- map["jobs"]
        
    }
    
}