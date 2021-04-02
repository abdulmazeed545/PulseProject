//
//  MenuController.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 27/03/21.
//

import UIKit

class MenuController: UITableViewController {

    private let menuItems:[String]
    
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        tableView.backgroundColor = .darkGray
        view.backgroundColor = .darkGray
       
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .systemTeal
        cell.textLabel?.backgroundColor = .darkGray
        cell.contentView.backgroundColor = .darkGray
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let leave = (storyboard?.instantiateViewController(identifier: "leave"))! as LeaveDetailsController
//            present(leave, animated: true, completion: nil)
            navigationController?.pushViewController(leave, animated: true)
            
        }else if indexPath.row == 1{
            let request = (storyboard?.instantiateViewController(identifier: "request"))! as RequestController
//            present(request, animated: true, completion: nil)
            navigationController?.pushViewController(request, animated: true)
        }else if indexPath.row == 2{
            
        }else if indexPath.row == 3{
          //  UserDefaults.standard.removeObject(forKey: "servicevariables")
           print("User defaults removed")
            if let data = HomeViewController.databaseConnection{
                do{
                   // try data.run("DELETE FROM userpulse")
                    print("deleted successfully")
                    dismiss(animated: true, completion: nil)
                    
//                    navigationController?.popToRootViewController(animated: true)
                    
                }catch{
                    
                    print("error occured in deleting file")
                }
            }
        }
    }
}
