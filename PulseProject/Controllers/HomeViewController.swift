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

    static var databaseConnection:Connection!
    var path:String = ""
    var loggedIN:String = ""
    static var login:LoginDataModel!
    var requestURL:URLRequest!
    var session:URLSessionDataTask!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        innerView.layer.cornerRadius = innerView.frame.width / 15
        path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        databaseCreation()
        
        do{
            let maz = try HomeViewController.databaseConnection.run("SELECT * FROM userpulse")
            
            for row in maz{
                let a = row[1]!
                loggedIN = a as! String
            }
            
        }catch{
            print("error in fetching the data")
        }
        if loggedIN == "yes"{
            let serviceVariables = UserDefaults.standard.object(forKey: "servicevariables")
            let urlString = Constants.baseURL + Constants.serverURL
            LoginDataParsing.shared.dataParser(urlString: urlString, serviceVariables: serviceVariables as! String) { (loginData: LoginDataModel) in
                HomeViewController.login = loginData
                DispatchQueue.main.async {
                    
                    let userHome = self.storyboard?.instantiateViewController(identifier: "tabbar") as! MyTabBar

                    self.navigationController?.pushViewController(userHome, animated: true)
                }
                
            }
            
        }
        // Do any additional setup after loading the view.
    }
    func databaseCreation(){
        
        do{
            HomeViewController.databaseConnection = try Connection("\(path)pulseproj.sqlite3")
            
        }catch{
            print("error occured:\(error.localizedDescription)")
        }
        //Creating a table in pulse database
        do{
            try HomeViewController.databaseConnection.run("create table IF NOT EXISTS userpulse (ID Integer primary key AUTOINCREMENT, loggedin text, email text, firstname text, surname text, profileimage text, studentid text, batchid text, role text)")
            print("table created")
        }catch{
            print("error in creating table:\(error.localizedDescription)")
        }
    }
    
    @IBAction func login(_ sender: UIButton) {
        
        let myEmail = email.text!
        let myPassword = password.text!
        
        let serviceVariables = "\(Constants.registeredEmail+myEmail)&\(Constants.registeredPassword+myPassword)&\(Constants.funcName)"
        let urlString = Constants.baseURL + Constants.serverURL
 
        UserDefaults.standard.setValue(serviceVariables, forKey: "servicevariables")
       
        LoginDataParsing.shared.dataParser(urlString: urlString, serviceVariables: serviceVariables) { (userLoginData: LoginDataModel) in
            
            HomeViewController.login = userLoginData
            do{
                try HomeViewController.databaseConnection.run("insert into userpulse (loggedin, email, firstname, surname, profileimage, studentid, batchid, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)", userLoginData.loggedIn, userLoginData.registeredEmail, userLoginData.firstName, userLoginData.surName, userLoginData.profileImagePath, userLoginData.studentID, userLoginData.batchID, userLoginData.role)
                print("data inserted")
            }catch{
                print("error in inserting data:\(error.localizedDescription)")
            }
            
            //Starting the main thread
            DispatchQueue.main.async {
                
                
                let userHome = self.storyboard?.instantiateViewController(identifier: "tabbar") as! MyTabBar
                
                self.navigationController?.pushViewController(userHome, animated: true)
                
            }
        }
        
    }
  
    @IBAction func accountCreation(_ sender: UIButton) {
        
        let register = storyboard?.instantiateViewController(identifier: "Register") as! RegisterViewController
        navigationController?.pushViewController(register, animated: true)
    }
    
    @IBAction func brnWeb(_ sender: UIButton) {
        
        guard let url = URL(string: "https://www.brninfotech.com/") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}
