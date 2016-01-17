//
//  JobTableViewCell.swift
//  JenkinsApp
//
//  Created by xuemincai on 16/1/13.
//  Copyright © 2016年 xuemincai. All rights reserved.
//

import UIKit
import EZSwiftExtensions
import Log

enum JobCellState {
    case Success, Failure, Disenable
}

protocol JobCellProtocol {
    func jobCellBulid(jobName: String)
}

class JobTableViewCell: UITableViewCell {

    @IBOutlet weak var edgeView: UIView!
    @IBOutlet weak var jobNameLab: UILabel!
    var jobCellProtocol: JobCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     设置cell状态
     
     - parameter state: JobCellState
     */
    func setShowState(state: JobCellState) {
        
        switch state {
        case .Success:
            jobNameLab.textColor = UIColor(hex: 0x48A564)
            edgeView.backgroundColor = UIColor(hex: 0x48A564)
        case .Failure:
            jobNameLab.textColor = UIColor(hex: 0xD74445)
            edgeView.backgroundColor = UIColor(hex: 0xD74445)
        case .Disenable:
            jobNameLab.textColor = UIColor(hex: 0xE9EBEB)
            edgeView.backgroundColor = UIColor(hex: 0xE9EBEB)
        }
        
    }
    
    @IBAction func onClickBulid(sender: UIButton) {
        jobCellProtocol?.jobCellBulid(jobNameLab.text!)
    }

}
