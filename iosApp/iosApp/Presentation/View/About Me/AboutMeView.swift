//
//  AboutMeView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import COAF

struct AboutMeView: View {
    private let imageSize = 120.0
    @EnvironmentObject var viewModel: UserViewModelWrapper
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView {
                VStack {
                    profileImage
                    Text(viewModel.user.fullname)
                        .font(.largeTitle)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Text(viewModel.user.placeOfBirth.description_)
                    Divider()
                    contactInfo
                    placeOfBirth
                    currentResidence
                    about
                    citizenship
                    educationsList
                    experiencesList
                    activitiesList
                    Divider().id("bottom")
                }
                .padding(.bottom)
                .foregroundStyle(Color.textPrimary)
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .onAppear {
                reader.scrollTo("bottom")
            }
        }
    }
}

extension AboutMeView {
    var profileImage: some View {
        AsyncImageView(url: viewModel.user.imageUrl, size: imageSize)
    }
    
    var contactInfo: some View {
        VStack {
            sectionHeaderText("Contact Info")
            TextView(text: $viewModel.user.name,
                     title: "Name",
                     placeholder: "Enter your name")
            TextView(text: $viewModel.user.surname,
                     title: "Surname",
                     placeholder: "Enter your surname")
            TextView(text: $viewModel.user.fatherName,
                     title: "Father Name",
                     placeholder: "Enter your father name")
            HStack {
                CardView(title: "Birthday", font: .system(size: 14, weight: .bold)) {
                    DayMonthYearDatePicker(date: $viewModel.user.birthday)
                }
                CardView(title: "Gender", font: .system(size: 14, weight: .bold)) {
                    MenuView(title: viewModel.user.gender.stringValue,
                             current: $viewModel.user.gender,
                             options: Gender.entries)
                }
            }
            TextView(text: $viewModel.user.email,
                     title: "Email",
                     placeholder: "Enter your email address...")
            TextView(text: $viewModel.user.mobilePhone,
                     title: "Mobile Phone",
                     placeholder: "Enter your phone number...")
        }
    }
    
    var placeOfBirth: some View {
        VStack {
            sectionHeaderText("Place of Birth")
            HStack {
                TextView(text: $viewModel.user.placeOfBirth.country,
                         title: "Country")
                TextView(text: $viewModel.user.placeOfBirth.region,
                         title: "Region")
                TextView(text: $viewModel.user.placeOfBirth.city,
                         title: "City")
            }
        }
    }
    
    var currentResidence: some View {
        VStack {
            sectionHeaderText("Current Residence")
            HStack {
                TextView(text: $viewModel.user.currentResidence.country,
                         title: "Country")
                TextView(text: $viewModel.user.currentResidence.region,
                         title: "Region")
                TextView(text: $viewModel.user.currentResidence.city,
                         title: "City")
            }
        }
    }
    
    var about: some View {
        VStack {
            sectionHeaderText("About")
            TextView(text: $viewModel.user.about, title: "About (up to 100 words)", lineLimit: 10)
        }
    }
    
    var citizenship: some View {
        HStack {
            sectionHeaderText("SMART Citizenship", font: .body)
            Spacer()
            Toggle("", isOn: $viewModel.user.isSmartCitizen)
                .tint(Color.accentColor)
        }
        .padding(.trailing, 5)
    }
    
    var educationsList: some View {
        VStack {
            sectionHeaderText("Education")
            ForEach($viewModel.user.educations, id: \.id) { ed in
                education(ed)
            }
        }
    }
    
    @ViewBuilder
    func education(_ education: Binding<Education>) -> some View {
        @State var ed = education.wrappedValue
        EditableView(title: "University") {
            VStack(alignment: .leading, spacing: 8) {
                Text(ed.universityName)
                    .font(.system(size: 20, weight: .black))
                Text([ed.faculty, ed.department].joined(separator: " - "))
                Text([ed.startDate, ed.endDate].joined(separator: " - "))
            }
        } editor: {
            
            TextFieldView(text: $ed.universityName, title: "University", font: .system(size: 20, weight: .bold))
            TextFieldView(text: $ed.faculty, title: "Faculty", font: .system(size: 20, weight: .bold))
            TextFieldView(text: $ed.department, title: "Department", font: .system(size: 20, weight: .bold))
            MonthYearDatePicker(date: $ed.startDate, title: "Start Date")
            MonthYearDatePicker(date: $ed.endDate, title: "End Date")
        } onSave: {
            if let index = viewModel.user.educations.firstIndex(where: { $0.id == ed.id }) {
                viewModel.user.educations[index] = ed
            }
        }
    }
    
    var experiencesList: some View {
        VStack {
            sectionHeaderText("Experience")
            ForEach($viewModel.user.workExperiences, id: \.id) { experience in
                workExperience(experience: experience)
            }
        }
    }
    
    @ViewBuilder
    func workExperience(experience: Binding<WorkExperience>) -> some View {
        @State var exp = experience.wrappedValue
        EditableView(title: "Experience") {
            VStack(alignment: .leading, spacing: 8) {
                Text(experience.wrappedValue.position)
                    .font(.system(size: 20, weight: .black))
                Text([experience.wrappedValue.employee, experience.wrappedValue.employmentType.value].joined(separator: " - "))
                Text([experience.wrappedValue.startDate, experience.wrappedValue.endDate].joined(separator: " - "))
            }
        } editor: {
            TextFieldView(text: $exp.position, title: "University", font: .system(size: 20, weight: .bold))
            TextFieldView(text: $exp.employee, title: "Faculty", font: .system(size: 20, weight: .bold))
            CardView(title: "Employment Type") {
                MenuView(title: exp.employmentType.stringValue,
                         current: $exp.employmentType,
                         options: EmploymentType.entries)
            }
            MonthYearDatePicker(date: $exp.startDate, title: "Start Date")
            MonthYearDatePicker(date: $exp.endDate, title: "End Date")
        } onSave: {
            if let index = viewModel.user.workExperiences.firstIndex(where: { $0.id == exp.id }) {
                viewModel.user.workExperiences[index] = exp
            }
        }
    }
    
    var activitiesList: some View {
        VStack {
            sectionHeaderText("Activities")
            ForEach($viewModel.user.activities, id: \.id) { act in
                activity(activity: act)
            }
        }
    }
    
    @ViewBuilder
    func activity(activity: Binding<CoafActivity>) -> some View {
        @State var act = activity.wrappedValue
        EditableView(title: "Activity") {
            VStack(alignment: .leading, spacing: 8) {
                Text(activity.wrappedValue.name)
                    .font(.system(size: 20, weight: .black))
                Text([activity.wrappedValue.startDate, activity.wrappedValue.endDate].joined(separator: " - "))
            }
        } editor: {
            TextFieldView(text: $act.name, title: "Acitivity Name", font: .system(size: 20, weight: .bold))
            MonthYearDatePicker(date: $act.startDate, title: "Start Date")
            MonthYearDatePicker(date: $act.endDate, title: "End Date")
        } onSave: {
            if let index = viewModel.user.activities.firstIndex(where: { $0.id == act.id }) {
                viewModel.user.activities[index] = act
            }
        }
    }
    
}

@ViewBuilder
func sectionHeaderText(_ title: String, font: Font = .title2) -> some View {
    Text(title)
        .font(font)
        .fontWeight(.bold)
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(Color.accentColor)
        .lineLimit(1)
}

#Preview {
    AboutMeView().preferredColorScheme(.dark)
}

#Preview {
    ContainerView()
}
