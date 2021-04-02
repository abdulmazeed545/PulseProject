//
//  AttendanceSummaryCell.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 25/03/21.
//

import UIKit

class AttendanceSummaryCell: UITableViewCell {

    @IBOutlet weak var totalDays: UILabel!
    @IBOutlet weak var workDays: UILabel!
    @IBOutlet weak var leaves: UILabel!
    @IBOutlet weak var absents: UILabel!
    @IBOutlet weak var daysAttended: UILabel!
    @IBOutlet weak var updatesSent: UILabel!
    @IBOutlet weak var workingHrs: UILabel!
    @IBOutlet weak var workedHrs: UILabel!
    @IBOutlet weak var OvralSpentSum: UILabel!
    @IBOutlet weak var workedPDay: UILabel!
    @IBOutlet weak var shortagePDay: UILabel!
    @IBOutlet weak var lateOffice: UILabel!
    @IBOutlet weak var minHrMis: UILabel!
    @IBOutlet weak var maxPoints: UILabel!
    @IBOutlet weak var pointsEarned: UILabel!
    @IBOutlet weak var perScore: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
