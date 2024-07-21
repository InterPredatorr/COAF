//
//  String.swift
//  iosApp
//
//  Created by Sevak on 21.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

extension String {
    var toDayMonthYearDate: Date {
        return DateFormatter.dayMonthYear.date(from: self) ?? .distantPast
    }
    
    var toMonthYearDate: Date {
        return DateFormatter.monthYear.date(from: self) ?? .distantPast
    }
    
    var toDayMonthYearLocalDate: Kotlinx_datetimeLocalDate {
        return self.toDayMonthYearDate.toLocalDate
    }
    
    var toMonthYearLocalDate: Kotlinx_datetimeLocalDate {
        return self.toMonthYearDate.toLocalDate
    }
}
