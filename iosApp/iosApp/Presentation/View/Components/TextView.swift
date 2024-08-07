//
//  TextView.swift
//  iosApp
//
//  Created by Sevak on 20.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct TextView: View {
    
    @State private var isPresented = false
    @State private var height: CGFloat = .zero
    @Binding var text: String
    var title: String = ""
    var placeholder: String = ""
    var lineLimit: Int = 1
    var locked: Bool = false
    var alignment: Alignment = .leading
    
    var horizontalAlignment: HorizontalAlignment {
        return switch alignment {
        case .leading:
                .leading
        case .center:
                .center
        case .trailing:
                .trailing
        default:
                .leading
        }
    }
    
    var fraction: CGFloat {
        1 / (UIScreen.main.bounds.height / CGFloat(lineLimit * 40 + 200))
    }
    
    var body: some View {
        VStack(alignment: horizontalAlignment, spacing: 5) {
            if !title.isEmpty {
                Text(title)
                    .foregroundStyle(Color.textPrimary)
            }
            CardView {
                if text.isEmpty && !locked {
                    Text(placeholder)
                        .foregroundStyle(.gray)
                        .lineLimit(lineLimit)
                        .frame(maxWidth: .infinity, alignment: alignment)
                } else {
                    Text(text)
                        .lineLimit(lineLimit)
                        .frame(maxWidth: .infinity, alignment: alignment)
                }
            }
            .onTapGesture {
                if !locked {
                    isPresented = true
                }
            }
            .sheet(isPresented: $isPresented) {
                TextChangeView(text: $text,
                               title: title,
                               placeholder: placeholder,
                               lineLimit: lineLimit)
                .overlay {
                    GeometryReader { geometry in
                        Color.clear.preference(key: InnerHeightPreferenceKey.self,
                                               value: geometry.size.height)
                    }
                }
                .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                    height = newHeight
                }
                .presentationDetents([.height(height)])

            }
        }
    }
}

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    TextView(text: .constant(""), placeholder: "etner...")
}
