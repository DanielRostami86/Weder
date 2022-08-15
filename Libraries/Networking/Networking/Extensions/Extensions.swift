//
//  Extensions.swift
//  Networking
//
//  Created by Daniel Rostami on 15/8/2022.
//

import Foundation
import UIKit

extension String {
    func dateFromString(from fromFormat: dateStringFormatFrom, to toFormat: dateStringFormatTo) -> Date? {
        guard let time = UIApplication.shared.UTCToLocal(date: self,
                                                         from: fromFormat,
                                                         to: toFormat) else { return Date() }
        return time.dateFromUTC(to: toFormat)
    }
    
    func dateFromUTC(to toFormat: dateStringFormatTo) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat.rawValue
        
        if let today = dateFormatter.date(from: self) {
            return today
        } else {
            return Date()
        }
    }
}

extension UIApplication {
    func UTCToLocal(date: String,
                    from fromFormat: dateStringFormatFrom,
                    to toFormat: dateStringFormatTo) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        
        dateFormatter.dateFormat = toFormat.rawValue
        
        if let dtFinal = dt {
            return dateFormatter.string(from: dtFinal)
        } else {
            return nil
        }
    }
}

