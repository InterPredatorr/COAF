//
//  MainView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Shared

struct MainView: View {
        
    var body: some View {
        ZStack {
            Color.backgroundPrimary.ignoresSafeArea()
            BottomBarView()
                .padding(.top, 1)
                .onAppear {
                    UINavigationBar.appearance().backgroundColor = Color.backgroundPrimary.toUIColor
                }
        }

    }
}

#Preview {
    MainView()
}

#Preview {
    ContainerView()
}
