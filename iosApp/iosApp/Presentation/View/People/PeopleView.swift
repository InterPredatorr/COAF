//
//  PeopleView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import COAF

struct PeopleView: View {
    
    @EnvironmentObject var viewModel: UserViewModelWrapper
    @State private var showFilter = false
    var body: some View {
        NavigationView {
            VStack {
//                TextFieldView(text: $viewModel.filter.text, placeholder: "Search people...")
                ScrollView {
//                    List(viewModel.users.indices, id: \.self) { index in
//                        HStack {
//                            AsyncImageView(url: viewModel.users[index].imageUrl, size: 32)
//                            VStack {
//                                Text(viewModel.users[index].fullname)
//                                Text(viewModel.users[index].placeOfBirth.description_)
//                            }
//                        }
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 80)
//                    }
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
            .presentationDetents([.fraction(0.3)])
            .sheet(isPresented: $showFilter) {
                
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

#Preview {
    ContainerView()
}
