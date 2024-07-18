//
//  String + Extensions.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation


extension String {
    
    var toDate: Date {
        return DateFormatter.main.date(from: self) ?? .distantPast
    }
}
