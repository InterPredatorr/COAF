//
//  CalendarDatePicker.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct CalendarDatePicker: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        DatePicker(selectedDate.toString.isEmpty ? "Choose Date" : selectedDate.toString,
                   selection: $selectedDate,
                   displayedComponents: [.date])
        .blendMode(.destinationOver)
        .foregroundStyle(Color.accentColor)
        .tint(.accentColor)
        .frame(height: 20)
        .fixedSize(horizontal: false, vertical: true)
    }
}

#Preview {
    VStack {
        CalendarDatePicker(selectedDate: .constant(.now))
    }
}

#Preview {
    ContainerView()
}
