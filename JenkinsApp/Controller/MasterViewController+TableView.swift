//
//  MasterViewController+TableView.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/12.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import UIKit


extension MasterViewController {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = jobData?.jobs?.count {
            return count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JobTableViewCell") as! JobTableViewCell
        
        cell.jobNameLab.text = jobData!.jobs![indexPath.row].name!
        
        return cell
        
    }
}