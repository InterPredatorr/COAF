//
//  FilterView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 19.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Shared

struct FilterView: View {
    
    @EnvironmentObject private var viewModel: PeopleViewModel
    
    var body: some View {
            HStack {
                ForEach(Gender.entries, id: \.name) { option in
                    if option == .male { Spacer() }
                    Label(option.name.capitalized,
                          systemImage: isSelected(option) ? "checkmark.circle.fill" : "circlebadge")
                    .foregroundStyle(isSelected(option) ? Color.accentColor : .textPrimary)
                    .onTapGesture {
                        withAnimation {
                            viewModel.filter.gender = option
                        }
                    }
                    Spacer()
                }
            }
            .padding(.horizontal)
    }
    
    private func isSelected(_ option: Gender) -> Bool {
        viewModel.filter.gender == option
    }
}

#Preview {
    FilterView()
        .environmentObject(PeopleViewModel())
}

#Preview {
    ContainerView()
}
