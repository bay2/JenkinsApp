//
//  ServerDataManage.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/4.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import UIKit
import RealmSwift

class ServerDataManage: NSObject {
    
    let serverInfos = try! Realm().objects(ServerData)
    let realm = try! Realm()
    
    /**
     添加服务器信息
     
     - parameter serverInfo: 服务器信息
     
     - returns: 成功：true 失败：false
     */
    func addServerInfo(serverInfo: ServerData) -> Bool {
        
        realm.beginWrite()
        realm.add(serverInfo)
        do {
            try realm.commitWrite()
        } catch {
            return false
        }
        
        return true
        
    }
    
    /**
     服务器是否存在
     
     - parameter serverName: 服务器名
     
     - returns: 存在 true， 不存在false
     */
    func isExistServer(serverName: String) -> Bool {
        
        let resultServerInfo = realm.objects(ServerData).filter("serverName == '\(serverName)'")
        
        return !resultServerInfo.isEmpty
    }
    
    /**
     查找被选择的服务器信息
     
     - returns: 成功：服务器信息， 失败：nil
     */
    func querySelectedServerInfo() -> ServerData? {
        
        let resultServerInfo = realm.objects(ServerData).filter("isSelected == true")
        
        if resultServerInfo.isEmpty {
            return nil
        } else {
            return resultServerInfo[0]
        }
        
    }
    
    /**
     设置服务器被选择
     
     - parameter serverInfo: 服务信息
     */
    func setSelectedServer(serverInfo: ServerData) {
        
        realm.beginWrite()
        
        if let resultServerInfo = querySelectedServerInfo() {
            resultServerInfo.isSelected = false
            realm.add(resultServerInfo, update: true)
        }
        
        serverInfo.isSelected = true
        
        realm.add(serverInfo, update: true)
        
        try! realm.commitWrite()
    }
    
    /**
     删除服务信息
     
     - parameter serverInfo: 服务器信息
     */
    func deleteServerInfo(serverInfo: ServerData) {
        
        realm.beginWrite()
        
        realm.delete(serverInfo)
        
        try! realm.commitWrite()
        
    }
}
