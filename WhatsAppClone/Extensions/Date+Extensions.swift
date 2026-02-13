//
//  Date+Extensions.swift
//  WhatsAppClone
//
//  Created by S, Praveen (Cognizant) on 29/11/25.
//

import Foundation

extension Date {
    var dayOrTimeRepresentation : String {
        let date = Calendar.current
        let dateFormatter = DateFormatter()
        
        if date.isDateInToday(self) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: self )
        }
        else if date.isDateInYesterday(self) {
            return "Yesterday"
        }
        else {
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: self)
        }
    }
    var formatToTime : String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let formattedTime = dateFormatter.string(from: self)
        return formattedTime
    }
}
