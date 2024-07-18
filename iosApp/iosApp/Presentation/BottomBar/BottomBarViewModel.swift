//
//  BottomBarViewModel.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Shared

class BottomBarViewModel: ObservableObject {
    
    @Published var selectedTab: BottomTab = .myprofile
}
