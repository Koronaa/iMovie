//
//  String+Extensions.swift
//  iMovie
//
//  Created by Sajith Konara on 2021-08-22.
//

import Foundation

extension String{
    
    var year:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        if let date = dateFormatter.date(from: self){
            dateFormatter.dateFormat = "YYYY"
            return dateFormatter.string(from: date)
        }
        return "N/A"
    }
    
}
