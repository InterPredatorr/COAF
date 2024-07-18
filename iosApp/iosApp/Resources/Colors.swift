//
//  Colors.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import UIKit


extension Color {
    static let textPrimary = Color("textPrimary", bundle: .main)
    static let mainPrimary = Color("mainPrimary", bundle: .main)
    static let backgroundPrimary = Color("backgroundPrimary", bundle: .main)
}

extension Color {
    var toUIColor: UIColor {
        UIColor(self)
    }
}
