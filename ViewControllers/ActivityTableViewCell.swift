//
//  ActivityTableViewCell.swift
//  IntheKnow1
//
//  Created by mac on 2/21/23.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var activityDate: UILabel!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
        // Configure the view for the selected state
        func configure(with activity: ActivitySaved) {
            details.text = activity.details
            activityName.text = activity.name
            location.text = activity.location
            time.text = DateFormatter.time.string(from: activity.date!)
            activityDate.text = DateFormatter.activityDate.string(from: activity.date!)
        }
    
    
}
