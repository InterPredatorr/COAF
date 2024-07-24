//
//  EditingView.swift
//  iosApp
//
//  Created by Sevak on 24.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct EditingView<Content: View>: View {
    
    @Environment(\.dismiss) private var dismiss
    var title: String = ""
    @ViewBuilder var content: () -> Content
    var onSave: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 16, weight: .bold))
            ScrollView {
                content()
            }
            .scrollIndicators(.never)
            .onTapGesture {
                hideKeyboard()
            }
            HStack {
                ButtonView(title: "Save") {
                    onSave?()
                    dismiss()
                }
                ButtonView(title: "Close", color: .gray) {
                    dismiss()
                }
            }
        }
        .padding()
    }
}

#Preview {
    EditingView(title: "String") {
        TextFieldView()
        TextFieldView()
    }
}
