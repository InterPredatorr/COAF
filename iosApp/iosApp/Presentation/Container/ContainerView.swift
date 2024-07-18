//
//  ContainerView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ContainerView: View {
    
    var body: some View {
        NavigationView {
            MainView()
                .onTapGesture {
                    hideKeyboard()
                }
        }
        
    }
}

#Preview {
    ContainerView()
}
