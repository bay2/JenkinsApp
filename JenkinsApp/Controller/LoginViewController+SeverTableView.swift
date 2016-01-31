//
//  LoginViewController+SeverTableView.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/3.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController {
    
    /**
     配置cell显示
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: cell
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ServerCell") as! ServerTableViewCell
        
        cell.serverNameLab.text = serverManage.serverInfos[indexPath.row].serverName
        cell.layoutMargins = UIEdgeInsetsZero
        
        return cell
        
    }
    
    /**
     配置cell高度
     
     - parameter tableView:
     - parameter indexPath:
     
     - returns: 高度
     */
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    /**
     配置cell的个数
     
     - parameter tableView:
     - parameter section:
     
     - returns: 个数
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serverManage.serverInfos.count
    }
    
    /**
     cell点击处理
     
     - parameter tableView:
     - parameter indexPath:
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        expandServerList()
        
        serverLab.text = serverManage.serverInfos[indexPath.row].serverName
        jenkinsNetRequest.serverAddr = serverManage.serverInfos[indexPath.row].serverAddr
        
        serverManage.setSelectedServer(serverManage.serverInfos[indexPath.row])

    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete {
            
            if let serverInfo: ServerData = serverManage.serverInfos[indexPath.row] {
                
                if serverLab.text == serverInfo.serverName {
                    serverLab.text = ""
                }
                
                serverManage.deleteServerInfo(serverInfo)
                
            }
            
            
        }
        
    }
}

class ServerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var serverNameLab: UILabel!
    
}