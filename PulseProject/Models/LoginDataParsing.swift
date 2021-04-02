//
//  LoginDataParsing.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 19/03/21.
//


import Foundation
import UIKit
import SQLite
struct LoginDataParsing {
    
    static let shared = LoginDataParsing()
    
    
    func dataParser<T:Codable>(urlString:String, serviceVariables:String, completion: @escaping (T) -> Void)
    {
        var url = URLRequest(url: URL(string: urlString)!)
        url.httpMethod = Constants.POST
        var service = serviceVariables
        
        url.httpBody = service.data(using: String.Encoding.utf8)
        
        //Starting the data session
        var dataSession = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if err == nil{
                
                do{
                    let loginData = try JSONDecoder().decode(T.self, from: data!)
                    
                    
                    print(loginData)
                    completion(loginData)
                    
                    
                }catch{
                    print("Error occured:\(error.localizedDescription)")
                }
            }
            
            
        }
        dataSession.resume()
    }
    //Creating a function to get the student attendance details
    func studentAttendance(completion: @escaping (DashBoard) -> Void)
    {
        //Creating an URL request to the server
        var requestURL = URLRequest(url: URL(string: "https://pulse.brninfotech.com/pulse/modules/admin/DashboardSnippets.php")!)
               
        requestURL.httpMethod = "POST"
        
        //Creating and storing variable to pass the data
        let serviceVariables = "funcName=getUserAttendance&studentIDByAdmin=NoValue"
        
        
        requestURL.httpBody = serviceVariables.data(using: String.Encoding.utf8)
        
        //Creating an instance to the singleton class to get the data from the server
        var session = URLSession.shared.dataTask(with: requestURL) { (data, reponse, error) in
            //Checking the error is nil or not
            if (error == nil)
            {
                do
                {
                    //Converting the data using JSONSerialization class
                    var jsonData = try JSONDecoder().decode(DashBoard.self, from: data!)
                    completion(jsonData)
                }
                catch
                {
                    print("Oops Some Error occured")
                }
            }
            else
            {
                print("Some Error")
            }
        }
        session.resume()
        
    }
}
