//
//  StatusUpdateController.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 26/03/21.
//

import UIKit

class StatusUpdateController: UIViewController {

    
    @IBOutlet weak var firstHour: UITextField!
    
    @IBOutlet weak var secondHour: UITextField!
    
    @IBOutlet weak var thirdHour: UITextField!
    
    @IBOutlet weak var fourthHour: UITextField!
    
    @IBOutlet weak var fifthHour: UITextField!
    
    @IBOutlet weak var sixthHour: UITextField!
    
    @IBOutlet weak var seventhHour: UITextField!
    
    @IBOutlet weak var eightHour: UITextField!
    
    @IBOutlet weak var ninthHour: UITextField!
    
    @IBOutlet weak var tenthHour: UITextField!
    
    @IBOutlet weak var update: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        update.layer.cornerRadius = update.frame.width / 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func UpdateSent(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
