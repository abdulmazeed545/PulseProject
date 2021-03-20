//
//  UserHomeController.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 19/03/21.
//

import UIKit
import SQLite


class UserHomeController: UIViewController {

    var databaseConnection:Connection!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
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
