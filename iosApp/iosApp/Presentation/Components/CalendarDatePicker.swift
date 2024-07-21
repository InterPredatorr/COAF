//
//  CalendarDatePicker.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 18.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Shared

struct DayMonthYearDatePicker: View {
    
    @State private var selectedDate: Date
    @Binding var date: String
    var alignment: Alignment
    
    init(date: Binding<String>, alignment: Alignment = .center) {
        self.selectedDate = date.wrappedValue.toDayMonthYearDate
        self._date = date
        self.alignment = alignment
    }
    
    var body: some View {
        HStack {
            if alignment == .trailing { Spacer() }
            Text(date.isEmpty ? "Choose Date" : date)
            if alignment == .center { Spacer() }
            Image(systemName: "calendar")
                .foregroundStyle(Color.accentColor)
                .overlay {
                    DatePicker(selection: $selectedDate, displayedComponents: .date) { }
                        .labelsHidden()
                        .contentShape(.rect)
                        .colorMultiply(.clear)
                        .onChange(of: selectedDate) { newValue in
                            self.date = newValue.dayMonthYearString
                        }
                }
            if alignment == .leading { Spacer() }
        }
        
    }
}

struct MonthYearDatePicker: View {
    
    @Binding var date: String
    @State private var month: String
    @State private var year: String
    @State private var isPresented = false
    @State private var height: CGFloat = 0.0
    
    init(date: Binding<String>) {
        self._date = date
        self.month = String(date.wrappedValue.dropLast(5))
        self.year = String(date.wrappedValue.dropFirst(4))
    }
    
    var body: some View {
        Text(date)
            .onTapGesture {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
                MonthYearPicker(date: $date, month: $month, year: $year, height: $height)
                    .presentationDetents([.height(height)])
            }
    }
}

private struct MonthYearPicker: View {
    
    @Environment(\.dismiss) private var dismiss
    @Binding var date: String
    @Binding var month: String
    @Binding var year: String
    @Binding var height: CGFloat
    let startYear = 1950
    let endYear = 2050
    
    var body: some View {
        VStack {
            Text(date)
            HStack {
                Picker("", selection: $month) {
                    ForEach(Calendar.current.shortMonthSymbols, id: \.stringValue) { m in
                        Text(m).tag(m)
                    }
                }
                .frame(maxHeight: .infinity)
                .pickerStyle(.wheel)
                .tag("month")
                .onChange(of: month) { newMonth in
                    updateDate(newMonth: newMonth, newYear: year)
                }
                Picker("", selection: $year) {
                    ForEach(startYear...endYear, id: \.description) { y in
                        Text(String(y)).tag(y)
                    }
                }
                .frame(maxHeight: .infinity)
                .pickerStyle(.wheel)
                .tag("year")
                .onChange(of: year) { newYear in
                    updateDate(newMonth: month, newYear: newYear)
                }
            }
            .frame(height: 200)
            ButtonView(title: "Save") {
                dismiss()
            }
        }
        .padding()
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
    
    private func updateDate(newMonth: String, newYear: String) {
        let newDateString = "\(newMonth) \(newYear)"
        date = newDateString
    }
}

#Preview {
    VStack {
        DayMonthYearDatePicker(date: .constant("13-04-2001"))
    }
}

#Preview {
    ContainerView()
}
