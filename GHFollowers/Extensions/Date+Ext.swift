//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Sarkhan Jafarli on 10/5/22.
//

import UIKit

extension Date {
    func convertToStringFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
