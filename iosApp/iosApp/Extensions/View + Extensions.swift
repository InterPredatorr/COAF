//
//  View + Extensions.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
    
    
}
