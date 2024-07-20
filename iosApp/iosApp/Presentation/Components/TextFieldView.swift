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
    private let isBindable: Bool
    @Binding var text: String
    var value: String
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
    
    init(text: Binding<String>? = nil,
         value: String = "",
         title: String = "",
         placeholder: String? = nil,
         lineLimit: Int? = nil,
         locked: Bool = false,
         leftButton: @escaping () -> LeftButton = { EmptyView() },
         rightButton: @escaping () -> RightButton = { EmptyView() }) {
        if let text {
            self._text = text
            self.isBindable = true
        } else {
            self._text = Binding(get: { "" }, set: { _ in })
            self.isBindable = false
        }
        self.value = value
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
            content
            .disabled(locked)
            .textSelection(.enabled)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(lineLimit, reservesSpace: true)
            .padding(.vertical)
            .padding(.leading, 5)
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
    
    @ViewBuilder
    var content: some View {
        if isBindable {
            TextField(placeholder ?? "",
                      text: $text,
                      axis: isMultiline ? .vertical : .horizontal)
        } else {
            Text(value)
                .textSelection(.enabled)
        }
    }
}

#Preview {
    struct S: Stringable {
        var toString: String = "hello"
    }
    return TextFieldView(text: .constant(""), title: "gegfe", placeholder: "gege")
}


#Preview {
    ContainerView()
}
