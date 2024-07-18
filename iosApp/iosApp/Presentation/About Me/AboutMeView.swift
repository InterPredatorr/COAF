//
//  AboutMeView.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

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
                    Text(viewModel.user.placeOfBirth.descrition)
                    Divider()
                    contactInfo
                    placeOfBirth
                    currentResidence
                    about
                    citizenship
                    education
                    Divider().id("bottom")
                }
                .padding(.bottom)
                .foregroundStyle(Color.textPrimary)
            }
            .padding(.horizontal)
            .scrollIndicators(.hidden)
            .onAppear {
//                reader.scrollTo("bottom")
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
            TextFieldView(text: $viewModel.user.name,
                          title: "Name",
                          placeholder: "Enter your name")
            TextFieldView(text: $viewModel.user.surname,
                          title: "Surname",
                          placeholder: "Enter your surname")
            TextFieldView(text: $viewModel.user.fatherName,
                          title: "Father Name",
                          placeholder: "Enter your father name")
            HStack {
                TextFieldView(text: $viewModel.user.birthday,
                              title: "Birthday",
                              placeholder: "Choose...",
                              locked: true,
                              rightButton:  {
                    CalendarDatePicker(selectedDate: $viewModel.selectedBirthday)
                })
                TextFieldView(text: $viewModel.selectedGender,
                              title: "Gender",
                              placeholder: "",
                              locked: true,
                              rightButton:  {
                    MenuView(options: ["Male", "Female", "Other"]) { option in
                        viewModel.selectedGender = option
                    }
                })
            }
            TextFieldView(text: $viewModel.user.email,
                          title: "Email",
                          placeholder: "Enter your email address...")
            TextFieldView(text: $viewModel.user.mobilePhone,
                          title: "Mobile Phone",
                          placeholder: "Enter your phone number...")
        }
    }
    
    var placeOfBirth: some View {
        VStack {
            sectionHeaderText("Place of Birth")
            HStack {
                TextFieldView(text: $viewModel.user.placeOfBirth.country,
                              title: "Country")
                TextFieldView(text: $viewModel.user.placeOfBirth.region,
                              title: "Region")
                TextFieldView(text: $viewModel.user.placeOfBirth.city,
                              title: "City")
            }
        }
    }
    
    var currentResidence: some View {
        VStack {
            sectionHeaderText("Current Residence")
            HStack {
                TextFieldView(text: $viewModel.user.currentResidence.country,
                              title: "Country")
                TextFieldView(text: $viewModel.user.currentResidence.region,
                              title: "Region")
                TextFieldView(text: $viewModel.user.currentResidence.city,
                              title: "City")
            }
        }
    }
    
    var about: some View {
        VStack {
            sectionHeaderText("About")
            TextFieldView(text: $viewModel.user.about, title: "About (up to 100 words)", lineLimit: 10)
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
//            ForEach(viewModel.user.universities) { university in
//                CardView {
//                    VStack {
//
//                    }
//                }
//            }
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
}

#Preview {
    AboutMeView().preferredColorScheme(.dark)
}

#Preview {
    MainView()
}
