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
        Image(systemName: "calendar")
            .font(.title3)
            .overlay {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .blendMode(.destinationOver)
                    .onChange(of: selectedDate) { value in
                        
                    }
            }
    }
}

#Preview {
    VStack {
        CalendarDatePicker(selectedDate: .constant(.now))
    }
}
