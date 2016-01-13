//
//  ServerData.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/3.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import Foundation
import RealmSwift

class ServerData: Object {
    
// Specify properties to ignore (Realm won't persist these)
    
    dynamic var serverName: String?
    dynamic var serverAddr: String?
    dynamic var isSelected = false
    
    override static func primaryKey() -> String? {
        return "serverName"
    }
    
}
