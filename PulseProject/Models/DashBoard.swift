//
//  DashBoard.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 24/03/21.
//

import Foundation
struct DashBoard : Codable {
    var summary:Summary
    var detailed:[Detailed]
}
struct Summary : Codable{
    
    var totalDays : Int
    var totalWorkingDays : Int
    var totalWorkingHours : String
    var totalWorkedHours : String
    var totalShortageHours : String
    var avgWorkingHours : String
    var avgShortageHours : String
    var totalAbsents : Int
    var totalLeaves : Int
    var numberOfTimesLateToOffice : Int
    var numberOfTimesLeftEarly : Int
    var numberOfTimesMinimumHoursMissed : Int
    var totalDaysAttended : Int
    var totalUpdatesSent : Int
    var lastAttendedDate : String
    var lastCheckInTime : String
    var avgEfforts : Int
    var avgShortageOrExceedEfforts : Int
    var maxPoints : Int
    var pointsScored : Int
    var percScored : String
    
}
struct Detailed: Codable {
    var attendanceDayCount : Int
    var attendanceDate: String
    var dayType: String
    var checkIn : String?
    var checkOut : String?
    var timeSpent : String
    var shortageExcessTime : String
    var totalPoints : Int?
}
