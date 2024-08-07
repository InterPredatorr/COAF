//
//  MyProfileView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import COAF

struct MyProfileView: View {
    
    @EnvironmentObject var userViewModel: UserViewModelWrapper
    @StateObject var viewModel = MyProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                tabs
                TabView(selection: $viewModel.selectedTab) {
                    AboutMeView()
                        .environmentObject(userViewModel)
                        .tag(MyProfileTab.aboutme)
                    CoafPassportView()
                        .environmentObject(userViewModel)
                        .tag(MyProfileTab.coafpassport)
                    ResourcesView()
                        .environmentObject(userViewModel)
                        .tag(MyProfileTab.resources)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut, value: viewModel.selectedTab)
                .transition(.slide)
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
            .foregroundStyle(.gray)
        }
    }
}

extension MyProfileView {
    var tabs: some View {
        VStack(spacing: 0) {
            Rectangle()
                .stroke(lineWidth: 1)
                .fill(Color.accentColor)
                .frame(height: 1)
            HStack(alignment: .center) {
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(MyProfileTab.entries, id: \.title) { tab in
                                let isSelected = tab.title == viewModel.selectedTab.title
                                VStack(spacing: 0) {
                                    Spacer()
                                    Text(tab.title)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .foregroundStyle(isSelected ? Color.accentColor : .textPrimary)
                                    Spacer()
                                    if isSelected {
                                        RoundedRectangle(cornerRadius: 2)
                                            .stroke(lineWidth: 2)
                                            .fill(isSelected ? Color.accentColor : .mainPrimary)
                                            .frame(height: 2)
                                    }
                                }
                                .id(tab.title)
                                .onTapGesture {
                                    viewModel.selectedTab = tab
                                    withAnimation {
                                        proxy.scrollTo(tab.title)
                                    }
                                }
                                .onChange(of: viewModel.selectedTab) { new in
                                    withAnimation {
                                        proxy.scrollTo(new.title, anchor: .center)
                                    }
                                }
                            }
                        }
                        .frame(height: 60)
                        .padding(.horizontal)
                    }
                }
                
            }
        }
        .background(Color.backgroundPrimary)
    }
}

#Preview {
    MyProfileView()
}

#Preview {
    ContainerView()
}
