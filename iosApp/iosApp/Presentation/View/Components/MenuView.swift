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
    var alignment: Alignment = .center
    
    var body: some View {
        Menu {
            ForEach(options, id: \.self) { option in
                Button(option.stringValue) {
                    current = option
                }
            }
        } label: {
            HStack {
                if alignment == .trailing {
                    Spacer()
                }
                Text(title)
                if alignment == .center {
                    Spacer()
                }
                Image(systemName: "chevron.down")
                    .foregroundStyle(Color.accentColor)
                if alignment == .leading {
                    Spacer()
                }
            }
            
        }
        
    }
}

#Preview {
    MenuView(title: "hello", current: .constant("Male"), options: ["Male", "Female"])
}

#Preview {
    ContainerView()
}
