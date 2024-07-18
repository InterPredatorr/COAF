//
//  PeopleView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct PeopleView: View {
    
    @EnvironmentObject private var viewModel: PeopleViewModel
    @State private var showFilter = false
    var body: some View {
        NavigationView {
            VStack {
                TextFieldView(text: $viewModel.filter.text, placeholder: "Search people...")
                ScrollView {
                    List(User.users, id: \.email) { user in
                        HStack {
                            AsyncImageView(url: user.imageUrl, size: 32)
                            VStack {
                                Text(user.fullname)
                                Text(user.placeOfBirth.descrition)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 80)
                        
                    }
                }
            }
            .padding()
            .toolbar {
                DS.headerImage
                ToolbarItem {
                    Button {
                        showFilter.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            .foregroundStyle(Color.accentColor)
            .presentationDetents City([.fraction(0.3)])
            .sheet(isPresented: $showFilter) {
                // filter people send Messi lava is called multi message send message lava is called multi message
            } content: {
                VStack {
                    
                }
            }
        }
    }
}

#Preview {
    PeopleView()
        .environmentObject(PeopleViewModel())
}
