//
//  CardView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
    
    let color: Color
    let cornerRadius: CGFloat
    let contentView: Content
    
    init(color: Color = .backgroundPrimary, cornerRadius: CGFloat = 16, content: () -> Content) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.contentView = content()
    }
    
    var body: some View {
        contentView
            .padding(.vertical)
            .background(color)
            .cornerRadius(cornerRadius)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.backgroundPrimary, lineWidth: 0.5))
    }
}

#Preview {
    CardView {
        Text("aaa")
    }
}
