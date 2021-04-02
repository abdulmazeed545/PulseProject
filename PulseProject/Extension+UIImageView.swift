//
//  Extension+UIImageView.swift
//  PulseProject
//
//  Created by Shaik abdul mazeed on 24/03/21.
//

import Foundation
import UIKit
extension UIImageView{
    
    func loadImage(urlString:String){
        
        let dataTask = URLSession.shared.dataTask(with: URL(string: urlString.replacingOccurrences(of: " ", with: "%20"))!, completionHandler: { (data, res, err) in
            if let data = data{
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        })
        dataTask.resume()
    }
}
