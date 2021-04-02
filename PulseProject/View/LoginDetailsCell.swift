//
//  LoginDetailsCell.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 24/03/21.
//

import UIKit

class LoginDetailsCell: UITableViewCell {

    @IBOutlet weak var proflieImage: UIImageView!
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var firstName: UILabel!
    
    @IBOutlet weak var studentID: UILabel!
    
    @IBOutlet weak var batchID: UILabel!
    
    @IBOutlet weak var role: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
