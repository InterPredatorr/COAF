//
//  CoafPassportView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct CoafPassportView: View {
    
    @StateObject var viewModel = MyProfileViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                programs
                clubs
            }
            .scrollIndicators(.hidden)
            
        }
        .padding(.horizontal)
    }
}

extension CoafPassportView {
    var programs: some View {
        VStack {
            sectionHeaderText("Programs")
            ForEach($viewModel.user.programs, id: \.issueDate) { program in
                CardView {
                    VStack(spacing: 5) {
                        TextFieldView(text: program.name)
                        TextFieldView(text: program.issueDate)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    var clubs: some View {
        VStack {
            sectionHeaderText("COAF Clubs")
            ForEach($viewModel.user.clubs, id: \.name) { club in
                CardView {
                    VStack(alignment: .leading, spacing: 5) {
                        TextFieldView(text: club.name)
                        HStack {
                            Text(club.position.wrappedValue.value)
                            MenuView(options: CoafClubPosition.allCases.map { $0.value }) { position in
                                viewModel.user.clubs.updateItem(\.id, club.id) { c in
                                    c.position = CoafClubPosition.allCases.first { $0.value == position }!
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CoafPassportView()
}
