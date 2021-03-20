//
//  UserHomeController.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 19/03/21.
//

import UIKit
import SQLite


class UserHomeController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    
    var databaseConnection:Connection!
    var login:[LoginDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func mySegmentAction(_ sender: UISegmentedControl) {
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        
        if let data = databaseConnection{
            do{
                try data.run("DELETE FROM pulseuser")
                print("deleted successfully")
                navigationController?.popToRootViewController(animated: true)
            }catch{

                print("error occured in deleting file")
            }
        }
        
        
        
        
    }
    

}
