//
//  String+Ext.swift
//  GitHubFollowers
//
//  Created by Ali Yasin Eser on 22.07.2022.
//

import Foundation


extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        convertToDate()?.convertToMonthYearFormat() ?? "N/A"
    }
}
