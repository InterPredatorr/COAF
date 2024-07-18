//
//  MenuView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    
    var systemIcon: String = "chevron.down"
    let options: [String]
    var onSelect: (String) -> ()
    
    var body: some View {
        Menu("", systemImage: systemIcon) {
            ForEach(options, id: \.self) { option in
                Button(option, action: { onSelect(option) })
            }
            .foregroundStyle(Color.accentColor)
        }
    }
}

#Preview {
    MenuView(options: ["Male", "Female"]) { option in
        
    }
}
