//
//  AttendanceDetailsCell.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 26/03/21.
//

import UIKit

class AttendanceDetailsCell: UITableViewCell {
    @IBOutlet weak var dayCount: UILabel!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var dayType: UILabel!
    @IBOutlet weak var checkIn: UILabel!
    @IBOutlet weak var checkOut: UILabel!
    @IBOutlet weak var timeSpent: UILabel!
    @IBOutlet weak var spentSummary: UILabel!
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var pointsEarned: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
