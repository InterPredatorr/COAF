//
//  PairView.swift
//  iosApp
//
//  Created by Sevak on 20.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct PairView<Content: View>: View {
    
    var title: String
    @ViewBuilder var value: () -> Content
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.gray)
            Spacer()
            value()
                .foregroundStyle(.textPrimary)
                .frame(alignment: .trailing)
        }
    }
}

#Preview {
    PairView(title: "Hello", value: { Text("World") })
}
