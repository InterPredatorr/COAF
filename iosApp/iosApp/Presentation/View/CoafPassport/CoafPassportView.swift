//
//  CoafPassportView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import COAF

struct CoafPassportView: View {
    
    @EnvironmentObject var viewModel: UserViewModelWrapper
    
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
            ForEach($viewModel.user.programs, id: \.id) { program in
                CardView {
                    VStack(spacing: 5) {
                        PairView(title: "Name:") {
                            TextView(text: program.name, alignment: .trailing)
                        }
                        PairView(title: "Issue Date:") {
                            DayMonthYearDatePicker(date: program.issueDate,
                                                   alignment: .trailing)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                
            }
        }
    }
    
    var clubs: some View {
        VStack {
            sectionHeaderText("COAF Clubs")
            ForEach($viewModel.user.clubs, id: \.id) { club in
                CardView {
                    VStack(spacing: 10) {
                        PairView(title: "Name:") {
                            TextView(text: club.name, alignment: .trailing)
                        }
                        PairView(title: "Position:") {
                            MenuView(title: club.position.wrappedValue.stringValue,
                                     current: club.position,
                                     options: CoafClubPosition.entries,
                                     alignment: .trailing)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

#Preview {
    CoafPassportView()
}

#Preview {
    ContainerView()
}
