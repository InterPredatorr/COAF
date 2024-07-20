//
//  Date + Extensions.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation


extension Date {
    var stringValue: String {
        return DateFormatter.main.string(from: self)
    }
}


extension DateFormatter {
    static var main: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter
    }
}
