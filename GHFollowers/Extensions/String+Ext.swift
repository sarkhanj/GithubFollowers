//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 10/5/22.
//

import UIKit

extension String  {
    func convertToDateFormat() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .autoupdatingCurrent
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDateFormat() else { return "N/A"}
        return date.convertToStringFormat()
    }
}


