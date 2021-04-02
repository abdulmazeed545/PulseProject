//
//  UserHomeController.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 19/03/21.
//

import UIKit
import SQLite
import SideMenu


class UserHomeController: UIViewController {

    var requestURL:URLRequest!
    var session:URLSessionDataTask!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mySegment: UISegmentedControl!
    var tableSegmentView:UITableView!
    var sideMenu:SideMenuNavigationController?
    
    var databaseConnection:Connection!
    var detailed:[Detailed] = []
    var loginData:LoginDataModel!
    var summary:DashBoard!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        loginData = HomeViewController.login
        if let myseg = mySegment{
            myseg.apportionsSegmentWidthsByContent = true
        }
        
        LoginDataParsing.shared.studentAttendance { (dashData) in
            self.summary = dashData
            self.detailed = dashData.detailed
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let table = tableView{
            table.reloadData()
        }
       
    }
   
    func createTV(){
        tableSegmentView = UITableView(frame: CGRect(x: 0, y: 144, width: 414, height: 752), style: UITableView.Style.plain)
        tableSegmentView.delegate = self
        tableSegmentView.dataSource = self
        tableSegmentView.backgroundColor = .systemPink
        tableSegmentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableSegmentView)

        tableSegmentView.reloadData()
    }
    
    @IBAction func mySegmentAction(_ sender: UISegmentedControl) {
        
        if mySegment.selectedSegmentIndex == 0{
            
            sideMenu = SideMenuNavigationController(rootViewController: MenuController(with: ["Apply Leave", "Create a Request", "Tasks", "Logout"]))
            sideMenu?.leftSide = true
            
            SideMenuManager.default.leftMenuNavigationController = sideMenu
            SideMenuManager.default.addPanGestureToPresent(toView: self.view)
//            navigationController?.pushViewController(sideMenu!, animated: true)
            present(sideMenu!, animated: true)
           
        }else if mySegment.selectedSegmentIndex == 1{
//            createTV(nibName: "LoginDetailsCell", identifier: "logincell")
            let loginDetail = UINib(nibName: "LoginDetailsCell", bundle: nil)
            tableView.register(loginDetail, forCellReuseIdentifier: "logincell")
            tableView.reloadData()
        }else if mySegment.selectedSegmentIndex == 2{
//            createTV(nibName: "AttendanceSummaryCell", identifier: "attendance")
            let attendanceSum = UINib(nibName: "AttendanceSummaryCell", bundle: nil)
            tableView.register(attendanceSum, forCellReuseIdentifier: "attendance")
            tableView.reloadData()
        }else if mySegment.selectedSegmentIndex == 3{
//            createTV(nibName: "AttendanceDetailsCell", identifier: "AttendanceDetailsCell")
            let attendanceDet = UINib(nibName: "AttendanceDetailsCell", bundle: nil)
            tableView.register(attendanceDet, forCellReuseIdentifier: "AttendanceDetailsCell")
            tableView.reloadData()
        }
        else if mySegment.selectedSegmentIndex == 4{
            let status = storyboard?.instantiateViewController(identifier: "status") as! StatusUpdateController
            navigationController?.pushViewController(status, animated: true)
        }
        
    }
    
        
    @IBAction func logoutscreen(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.removeObject(forKey: "servicevariables")
        if let data = HomeViewController.databaseConnection{
            do{
                try data.run("DELETE FROM userpulse")
                print("deleted successfully")
                navigationController?.navigationController?.popToRootViewController(animated: true)
            }catch{
                
                print("error occured in deleting file")
            }
        }
    }
    
}
extension UserHomeController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var a = 0
        if mySegment.selectedSegmentIndex == 1{
           a = 1
        }else if mySegment.selectedSegmentIndex == 2{
            a = 1
        }else if mySegment.selectedSegmentIndex == 3{
            a = detailed.count
        }
        return a
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var myCell = UITableViewCell()
        
        if mySegment.selectedSegmentIndex == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "logincell", for: indexPath) as! LoginDetailsCell
            cell.email.text = "Registered Email: \(loginData.registeredEmail)"
            cell.firstName.text = "\(loginData.firstName)"
            cell.batchID.text = "BatchID: \(loginData.batchID)"
            cell.studentID.text = "StudentID: \(loginData.studentID)"
            cell.role.text = "Role: \(loginData.role)"
            
            let profileImage = loginData.profileImagePath
            let profile = profileImage.split(separator: ".")
            print(profile)
            let urlString = Constants.baseURL+profile[0]+".\(profile[1])"
            print(urlString)
            cell.proflieImage.loadImage(urlString: urlString)
            cell.proflieImage.layer.cornerRadius = cell.proflieImage.frame.height / 1.9
            myCell = cell
        }else if mySegment.selectedSegmentIndex == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "attendance", for: indexPath) as! AttendanceSummaryCell
            cell.totalDays.text = "Total Days: \(summary.summary.totalDays)"
            cell.workDays.text = "Working Days: \(summary.summary.totalWorkingDays)"
            cell.leaves.text = "Leaves: \(summary.summary.totalLeaves)"
            cell.absents.text = "Absents: \(summary.summary.totalAbsents)"
            cell.daysAttended.text = "Days Attended: \(summary.summary.totalDaysAttended)"
            cell.updatesSent.text = "Updates Sent: \(summary.summary.totalUpdatesSent)"
            cell.workingHrs.text = "Working Hrs: \(summary.summary.totalWorkingHours)"
            cell.workedHrs.text = "Worked Hrs:\(summary.summary.totalWorkedHours)"
            cell.OvralSpentSum.text = "SpentSummary: \(summary.summary.totalShortageHours)"
            cell.workedPDay.text = "Worked Per Day: \(summary.summary.avgWorkingHours)"
            cell.shortagePDay.text = "Shortage Per Day: \(summary.summary.avgShortageHours)"
            cell.lateOffice.text = "Late to Office: \(summary.summary.numberOfTimesLateToOffice)"
            cell.minHrMis.text = "Min Hrs Missed: \(summary.summary.numberOfTimesMinimumHoursMissed)"
            cell.maxPoints.text = "MaxPoints: \(summary.summary.maxPoints)"
            cell.pointsEarned.text = "Max Points Earned: \(summary.summary.pointsScored)"
            cell.perScore.text = "Performance Score: \(summary.summary.percScored)"
            cell.layer.cornerRadius = cell.frame.size.width / 20
            myCell = cell
        }else if mySegment.selectedSegmentIndex == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttendanceDetailsCell", for: indexPath) as! AttendanceDetailsCell
            let detail = detailed[indexPath.row]
            
            cell.dayCount.text = "Day Count: \(detail.attendanceDayCount)"
            cell.date.text = "Date: \(detail.attendanceDate)"
            cell.dayType.text = "Day Type: \(detail.dayType)"
            cell.checkIn.text = "Check In: \(detail.checkIn ?? "nil")"
            cell.checkOut.text = "Check Out: \(detail.checkOut ?? "nil")"
            cell.timeSpent.text = "Time Spent: \(detail.timeSpent)"
            cell.spentSummary.text = "Spent Summary: \(detail.shortageExcessTime)"
            cell.pointsEarned.text = "Point Earned: \(detail.totalPoints ?? 0)"
            
            cell.myView.layer.cornerRadius = 30
            myCell = cell
        }
        
        return myCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var a:CGFloat = 0.0
        if mySegment.selectedSegmentIndex == 1{
            a = 487
        }else if mySegment.selectedSegmentIndex == 2{
            a = 600
        }else if mySegment.selectedSegmentIndex == 3{
            a = 412
        }
        return a
    }
    
    
}


