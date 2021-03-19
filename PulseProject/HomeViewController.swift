//
//  HomeViewController.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 19/03/21.
//
import SafariServices
import UIKit
import SQLite

class HomeViewController: UIViewController {

    var databaseConnection:Connection!
    var path:String = ""
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        innerView.layer.cornerRadius = innerView.frame.width / 15
        path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        print(path)
        databaseCreation()
        // Do any additional setup after loading the view.
    }
    func databaseCreation(){
        
        do{
           databaseConnection = try Connection("\(path)pulse.sqlite3")
            
        }catch{
            print("error occured:\(error.localizedDescription)")
        }
        //Creating a table in pulse database
        do{
            try databaseConnection.run("create table IF NOT EXISTS user (ID Integer primary key AUTOINCREMENT, email text, loggedin text)")
        }catch{
            print("error in creating table:\(error.localizedDescription)")
        }
        
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let myEmail = email.text!
        let myPassword = password.text!
        let serviceVariables = "\(Constants.registeredEmail+myEmail)&\(Constants.registeredPassword+myPassword)&\(Constants.funcName)" 
       print(serviceVariables)
        LoginDataParsing.shared.dataParser(serviceVariables: serviceVariables) { (userLoginData) in

            do{
                try self.databaseConnection.run("insert into user(email, loggedin) VALUES (?, ?)", userLoginData.registeredEmail, userLoginData.loggedIn)
            }catch{
                print("error in inserting data:\(error.localizedDescription)")
            }
            
        }
        
    }
    
    @IBAction func accountCreation(_ sender: UIButton) {
        
        let register = storyboard?.instantiateViewController(identifier: "Register") as! RegisterViewController
        register.modalPresentationStyle = .fullScreen
        present(register, animated: true, completion: nil)
        
    }
    
    @IBAction func brnWeb(_ sender: UIButton) {
        
        guard let url = URL(string: "https://www.brninfotech.com/") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)

    }
    
}
