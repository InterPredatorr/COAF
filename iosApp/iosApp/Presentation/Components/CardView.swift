//
//  CardView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct CardView<Content: View>: View {
    
    var title: String = ""
    var color: Color = .backgroundPrimary
    var font: Font = .system(size: 20, weight: .bold)
    var cornerRadius: CGFloat = 16
    var leading: CGFloat = 5
    var trailing: CGFloat = 5
    @ViewBuilder var contentView: () -> Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !title.isEmpty {
                Text(title)
                    .font(font)
            }
            contentView()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, leading)
                .padding(.trailing, trailing)
                .padding(.vertical)
                .background(color)
                .cornerRadius(cornerRadius)
                .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.backgroundPrimary, lineWidth: 0.5))
        }
            
    }
}

#Preview {
    CardView {
        Text("aaa")
    }
}

#Preview {
    ContainerView()
}
