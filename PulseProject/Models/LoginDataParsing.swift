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
    
    
    func dataParser(serviceVariables:String, completion: @escaping (LoginDataModel) -> Void)
    {
        var url = URLRequest(url: URL(string: Constants.baseURL + Constants.serverURL)!)
        url.httpMethod = Constants.POST
        var service = serviceVariables
        
        url.httpBody = service.data(using: String.Encoding.utf8)
        
        //Starting the data session
        var dataSession = URLSession.shared.dataTask(with: url) { (data, res, err) in
            if err == nil{
                
                do{
                    let loginData = try JSONDecoder().decode(LoginDataModel.self, from: data!)
                    
                    
                    print(loginData)
                    completion(loginData)
                    
                }catch{
                    print("Error occured:\(error.localizedDescription)")
                }
            }
            
            
        }
        dataSession.resume()
    }
}
