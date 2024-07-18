//
//  TextFieldView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct TextFieldView<RightButton: View, LeftButton: View>: View {
    
    enum Field: Hashable {
        case about
    }
    
    @Binding var text: String
    var title: String
    var placeholder: String?
    var lineLimit: Int
    var locked: Bool
    @ViewBuilder var leftButton: () -> LeftButton
    @ViewBuilder var rightButton: () -> RightButton
    
    var isMultiline: Bool {
        get {
            lineLimit > 1
        }
    }
    
    init(text: Binding<String>,
         title: String = "",
         placeholder: String? = nil,
         lineLimit: Int? = nil,
         locked: Bool = false,
         leftButton: @escaping () -> LeftButton = { EmptyView() },
         rightButton: @escaping () -> RightButton = { EmptyView() }) {
        self._text = text
        self.title = title
        self.placeholder = placeholder
        self.lineLimit = lineLimit ?? 1
        self.locked = locked
        self.rightButton = rightButton
        self.leftButton = leftButton
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if !title.isEmpty {
                Text(title)
                    .foregroundStyle(Color.textPrimary)
            }
            TextField(placeholder ?? "",
                      text: $text,
                      axis: isMultiline ? .vertical : .horizontal)
                .disabled(locked)
                .textSelection(.enabled)
                .multilineTextAlignment(.leading)
                .lineLimit(lineLimit, reservesSpace: true)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.backgroundPrimary)
                .clipShape(.rect(cornerRadius: 12))
                .overlay {
                    HStack {
                        leftButton()
                        Spacer()
                        rightButton()
                    }
                    .padding(.horizontal)
                    
                }
                
                
        }
        .foregroundStyle(Color.textPrimary)
    }
}

#Preview {
    TextFieldView(text: .constant("hello"), title: "gegfe", placeholder: "gege")
}

