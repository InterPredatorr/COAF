//
//  AboutMeView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Shared

struct AboutMeView: View {
    private let imageSize = 120.0
    @StateObject var viewModel = MyProfileViewModel()
    
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
                    education
                    workExperience
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
                VStack(alignment: .leading) {
                    Text("Birthday")
                    CardView {
                        DayMonthYearDatePicker(date: $viewModel.user.birthday)
                    }
                }
                VStack(alignment: .leading) {
                    Text("Gender")
                    CardView {
                        MenuView(title: viewModel.user.gender.stringValue,
                                 current: $viewModel.user.gender,
                                 options: Gender.entries)
                    }
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
    
    var education: some View {
        VStack {
            sectionHeaderText("Education")
            ForEach($viewModel.user.educations, id: \.id) { education in
                let ed = education.wrappedValue
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(ed.universityName)
                            .font(.system(size: 20, weight: .black))
                        Text([ed.faculty, ed.department].joined(separator: " - "))
                        HStack {
                            MonthYearDatePicker(date: education.startDate)
                            Text(" - ")
                            MonthYearDatePicker(date: education.endDate)
                        }
                    }
                }
            }
        }
    }
    
    var workExperience: some View {
        VStack {
            sectionHeaderText("Experience")
            ForEach($viewModel.user.workExperiences, id: \.id) { experience in
                let exp = experience.wrappedValue
                CardView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(exp.position)
                            .font(.system(size: 20, weight: .black))
                        Text([exp.employee, exp.employmentType.value].joined(separator: " - "))
                        HStack {
                            MonthYearDatePicker(date: experience.startDate)
                            Text(" - ")
                            MonthYearDatePicker(date: experience.endDate)
                        }
                    }
                }
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
