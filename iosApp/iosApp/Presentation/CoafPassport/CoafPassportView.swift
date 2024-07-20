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
            ForEach($viewModel.user.programs, id: \.id) { program in
                CardView {
                    VStack(spacing: 5) {
                        PairView(title: "Name:") { TextView(text: program.name) }
                        PairView(title: "Issue Date:") {
                            CalendarDatePicker(selectedDate: program.issueDate)
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
                        PairView(title: "Name:") { Text(club.name.wrappedValue) }
                        PairView(title: "Position:") {
                            MenuView(title: club.position.wrappedValue.toString,
                                     current: club.position,
                                     options: CoafClubPosition.allCases)
                        }
                        
                    }
                    .padding(.horizontal)
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
