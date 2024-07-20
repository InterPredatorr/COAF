//
//  MenuView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct MenuView<S: Stringable & Hashable>: View {
    
    var systemIcon: String = "chevron.down"
    var title: String
    @Binding var current: S
    let options: [S]
    
    var body: some View {
        Menu(title) {
            ForEach(options, id: \.self) { option in
                Button(option.toString.capitalized) {
                    current = option
                }
            }
        }
        .foregroundStyle(Color.accentColor)
    }
}

#Preview {
    MenuView(title: "hello", current: .constant("Male"), options: ["Male", "Female"])
}

#Preview {
    ContainerView()
}
