//
//  MyTabBar.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 29/03/21.
//

import UIKit

class MyTabBar: UITabBarController {
    var loginData:LoginDataModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
//        navigationController?.isNavigationBarHidden = true
        let userHome = storyboard?.instantiateViewController(identifier: "userhome") as! UserHomeController
        //userHome.loginData = loginData
        //print("User Home Controller:", loginData!)
        //navigationController?.pushViewController(userHome, animated: true)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "servicevariables")
        if let data = HomeViewController.databaseConnection{
            do{
                try data.run("DELETE FROM userpulse")
                print("deleted successfully")
                navigationController?.popToRootViewController(animated: true)
            }catch{
                
                print("error occured in deleting file")
            }
        }
    }
    
}
