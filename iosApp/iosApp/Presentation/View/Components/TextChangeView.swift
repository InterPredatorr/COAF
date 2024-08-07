//
//  TextChangeView.swift
//  iosApp
//
//  Created by Sevak on 20.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct TextChangeView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var text: String
    var title: String = ""
    var placeholder: String = ""
    var lineLimit: Int = 1
    
    var body: some View {
        VStack(spacing: 30) {
            TextFieldView(text: $text,
                          title: title,
                          placeholder: placeholder,
                          lineLimit: lineLimit)
            ButtonView(title: "Save") {
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    TextChangeView(text: .constant("Hello"))
}
