//
//  LoginDataModel.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 19/03/21.
//

import Foundation
struct LoginDataModel: Codable {
    
    var registeredEmail:String
    var firstName:String
    var surName:String
    var profileImagePath:String
    var studentID:String
    var batchID:String
    var role:String
    var loggedIn:String
}
