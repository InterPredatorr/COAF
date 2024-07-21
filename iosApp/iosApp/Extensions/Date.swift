//
//  Date.swift
//  iosApp
//
//  Created by Sevak on 21.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

extension Date {
    var dayMonthYearString: String {
        return DateFormatter.dayMonthYear.string(from: self)
    }
    
    var monthYearString: String {
        return DateFormatter.monthYear.string(from: self)
    }
    
    var toLocalDate: Kotlinx_datetimeLocalDate {
        return .init(year: Int32(self.get(.year)),
                     month: self.get(.month).toLocalDateMonth,
                     dayOfMonth: Int32(self.get(.day)))
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}


extension DateFormatter {
    static var dayMonthYear: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }
    
    static var monthYear: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter
    }
}
