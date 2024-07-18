//
//  HomeView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home")
            }
            .toolbar {
                DS.headerImage
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "bell.fill")
                    }
                }
                ToolbarItem {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
            .foregroundStyle(Color.accentColor)
        }
        
    }
}

#Preview {
    HomeView()
}

#Preview {
    MainView()
}

