//
//  BottomBarView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import COAF

struct BottomBarView: View {
    
    @EnvironmentObject var viewModel: UserViewModelWrapper
    @StateObject var bottomBarViewModel = BottomBarViewModel()
    
    var body: some View {
        
        TabView(selection: $bottomBarViewModel.selectedTab) {
            HomeView()
                .tag(BottomTab.home)
                .tabItem {
                    Label(BottomTab.home.title, systemImage: "house.fill")
                }
            PeopleView()
                .environmentObject(viewModel)
                .tag(BottomTab.people)
                .tabItem {
                    Label(BottomTab.people.title, systemImage: "person.3.fill")
                }
            FilesView()
                .tag(BottomTab.files)
                .tabItem {
                    Label(BottomTab.files.title, systemImage: "folder.fill")
                }
            MyProfileView()
                .environmentObject(viewModel)
                .tag(BottomTab.myprofile)
                .tabItem {
                    Label(BottomTab.myprofile.title, systemImage: "person.circle.fill")
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = Color.backgroundPrimary.toUIColor
        }
    }
}

#Preview {
    BottomBarView()
}

#Preview {
    ContainerView()
}
