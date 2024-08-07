//
//  EditableView.swift
//  iosApp
//
//  Created by Sevak on 24.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct EditableView<Main: View, Editor: View>: View {
    
    @State private var height: CGFloat = .zero
    @State private var isPresented = false
    let title: String
    var main: () -> Main
    var editor: () -> Editor
    let onSave: () -> Void
    
    init(title: String = "",
         @ViewBuilder main: @escaping () -> Main,
         @ViewBuilder editor: @escaping () -> Editor = { EmptyView() },
         onSave: @escaping () -> Void
    ) {
        self.title = title
        self.main = main
        self.editor = editor
        self.onSave = onSave
    }
    
    var body: some View {
        CardView {
            main()
        }
        .onTapGesture {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            
            EditingView(title: title) {
                editor()
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
            } onSave: {
                onSave()
            }
            .interactiveDismissDisabled()
        }
        
    }
}

#Preview {
    EditableView {
        Text("Hello")
    } editor: {
        TextFieldView()
    } onSave: {
        
    }
}
