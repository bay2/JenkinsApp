//
//  MasterViewController+TableView.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/12.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import UIKit
import Log
import EZSwiftExtensions


extension MasterViewController : JobCellProtocol{
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JobTableViewCell") as! JobTableViewCell
        
        cell.jobNameLab.text = jobData!.jobs![indexPath.section].name!
        let statColor = jobData!.jobs![indexPath.section].statColor!
        cell.jobCellProtocol = self
        
        switch statColor {
        case "blue":
            cell.setShowState(.Success)
        case "red":
            cell.setShowState(.Failure)
        case "disabled" :
            cell.setShowState(.Disenable)
        default:
            Log.error("State error [\(statColor)]")
            
        }
        
        return cell
        
    }
    
    func jobCellBulid(jobName: String) {

        jenkinsNetRequest.httpPost(.Build, para: ["jobName" : jobName]) { (result) -> Void in
            
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if let count = jobData?.jobs?.count {
            return count
        }
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 8 }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { return 0 }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        
        return view
            
    }
}