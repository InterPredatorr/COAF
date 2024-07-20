//
//  ButtonView.swift
//  iosApp
//
//  Created by Sevak on 20.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ButtonView: View {
    
    let title: String
    let color: Color
    let onClick: () -> Void
    
    init(title: String,
         color: Color = .accentColor,
         onClick: @escaping () -> Void) {
        self.title = title
        self.color = color
        self.onClick = onClick
    }
    
    var body: some View {
        CardView(color: color) {
            Button {
                onClick()
            } label: {
                Text(title)
                    .foregroundStyle(.mainPrimary)
                    .font(.system(size: 20, weight: .black))
            }
            .frame(maxWidth: .infinity)
        }
        
    }
}

#Preview {
    ButtonView(title: "Save") {
        //
    }
}
