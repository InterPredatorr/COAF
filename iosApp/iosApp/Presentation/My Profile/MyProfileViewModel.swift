//
//  MyProfileViewModel.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 05.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Combine
import Shared

enum Gender: String, CaseIterable, Stringable {
    case male
    case female
    case other
    
    var toString: String {
        self.rawValue.capitalized
    }
    
}

struct Address {
    var country: String
    var region: String
    var city: String
    
    var descrition: String {
        [city, region, country].joined(separator: ", ")
    }
    
    static let empty = Self(country: "Armenia",
                            region: "Aragatsotn",
                            city: "Arteni")
}

struct University {
    var name: String
    var faculty: String
    var department: String
    var startDate: Date
    var endDate: Date
    
    static let empty = Self(name: "Yerevan State University",
                            faculty: "Informatics and Applied Mathematics",
                            department: "Information Security",
                            startDate: "01-09-2021".toDate,
                            endDate: .now)
}

struct Experience {
    var employee: String
    var position: String
    var startDate: Date
    var endDate: Date
    
    static let empty = Self(employee: "PicsArt",
                            position: "Software Engineer",
                            startDate: "01-11-2022".toDate,
                            endDate: .now)
}

struct Activity {
    var name: String
    var startYear: Int
    var endYear: Int
    
    static let empty = Self(name: "Student Council",
                            startYear: 2015,
                            endYear: 2018)
}

struct Certificate {
    var providerName: String
    var yearOfProvision: Int
    var name: String
    
    static let empty = Self(providerName: "Arteni's Middle School",
                            yearOfProvision: 2019,
                            name: "School Completion")
}

struct CoafPassportProgram: Identifiable {
    var id = UUID()
    var name: String
    var issueDate: Date
    
    static func empty() -> Self { 
        Self(name: "Mentorship", issueDate: .now)
    }
    
    
}

enum CoafClubPosition: String, CaseIterable, Stringable {
    case attentdee
    case organizer
    
    var toString: String {
        self.rawValue.capitalized
    }
}

struct CoafClub: Identifiable {
    var id = UUID()
    var name: String
    var position: CoafClubPosition
    
    static func empty() -> Self {
        Self(name: "\(["English", "Debate"].randomElement()!) Club", position: CoafClubPosition.allCases.randomElement()!)
    }
}


class User {
    var imageUrl: String
    var name: String
    var surname: String
    var fatherName: String
    var birthday: Date
    var gender: Gender
    var email: String
    var mobilePhone: String
    var placeOfBirth: Address
    var currentResidence: Address
    var about: String
    var isSmartCitizen: Bool
    var universities: [University]
    var workExperiences: [Experience]
    var activities: [Activity]
    var certificates: [Certificate]
    var skills: [String]
    var programs: [CoafPassportProgram]
    var clubs: [CoafClub]
    
    var fullname: String {
        return [name, surname].joined(separator: " ")
    }
    
    init(imageUrl: String,
         name: String,
         surname: String,
         fatherName: String,
         birthday: Date,
         gender: Gender,
         email: String,
         mobilePhone: String,
         placeOfBirth: Address,
         currentResidence: Address,
         about: String,
         isSmartCitizen: Bool,
         universities: [University],
         workExperiences: [Experience],
         activities: [Activity],
         certificates: [Certificate],
         skills: [String],
         programs: [CoafPassportProgram],
         clubs: [CoafClub]) {
            self.imageUrl = imageUrl
            self.name = name
            self.surname = surname
            self.fatherName = fatherName
            self.birthday = birthday
            self.gender = gender
            self.email = email
            self.mobilePhone = mobilePhone
            self.placeOfBirth = placeOfBirth
            self.currentResidence = currentResidence
            self.about = about
            self.isSmartCitizen = isSmartCitizen
            self.universities = universities
            self.workExperiences = workExperiences
            self.activities = activities
            self.certificates = certificates
            self.skills = skills
            self.programs = programs
            self.clubs = clubs
        }
    
    private static let url = "https://scontent.fevn6-5.fna.fbcdn.net/v/t39.30808-1/421993184_3616149601969247_4268671215732508320_n.jpg?stp=dst-jpg_p480x480&_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_ohc=sa2bBGAjf0wQ7kNvgHMOnvt&_nc_ht=scontent.fevn6-5.fna&oh=00_AYBJsRfV9p_GWlEgmS3MiLjlDQKs_nn1Tu5VWFxLQtDMJQ&oe=664ED8E9"
    
    init() {
        imageUrl = User.url
        name = "Sevak"
        surname = "Tadevosyan"
        fatherName = "Samvel"
        birthday = "13-04-2001".toDate
        gender = .male
        email = "sevak.tadevosyan.dev@gmail.com"
        mobilePhone = "+37494610421"
        placeOfBirth = .empty
        currentResidence = .empty
        about = "I'm Sevak, from Arteni, I'm studying in Yerevan State University, at the faculty of Informatics and Applied Mathematics. In parallel, I'm working at PicsArt as a Software Engineer."
        isSmartCitizen = true
        universities = [.empty]
        workExperiences = [.empty]
        activities = [.empty]
        certificates = [.empty]
        skills = []
        programs = [.empty(), .empty()]
        clubs = [.empty(), .empty()]
    }
    
    static let users: [User] = [
        User(imageUrl: User.url, name: "Aram", surname: "Hakobyan", fatherName: "Hovhannes", birthday: "20-07-1995".toDate, gender: .male, email: "aram.hakobyan@example.com", mobilePhone: "+37491234567", placeOfBirth: Address(country: "Armenia", region: "Yerevan", city: "Yerevan"), currentResidence: Address(country: "Armenia", region: "Yerevan", city: "Yerevan"), about: "Passionate software developer with a knack for creating innovative solutions.", isSmartCitizen: true, universities: [University(name: "Armenian State University of Economics", faculty: "Business", department: "Finance", startDate: "01-09-2013".toDate, endDate: "30-06-2017".toDate)], workExperiences: [Experience(employee: "Tumo Center", position: "Developer", startDate: "01-07-2018".toDate, endDate: "01-08-2022".toDate)], activities: [Activity(name: "Coding Club", startYear: 2013, endYear: 2017)], certificates: [Certificate(providerName: "Coursera", yearOfProvision: 2019, name: "Machine Learning")], skills: ["Swift", "Python", "SQL"], programs: [.empty(), .empty()], clubs: [.empty(), .empty()]),
        User(imageUrl: User.url, name: "Lilit", surname: "Sargsyan", fatherName: "Armen", birthday: "15-05-1993".toDate, gender: .female, email: "lilit.sargsyan@example.com", mobilePhone: "+37493345678", placeOfBirth: Address(country: "Armenia", region: "Shirak", city: "Gyumri"), currentResidence: Address(country: "Armenia", region: "Yerevan", city: "Yerevan"), about: "Experienced data analyst with a strong background in statistics and programming.", isSmartCitizen: true, universities: [University(name: "American University of Armenia", faculty: "Computer Science", department: "Data Science", startDate: "01-09-2011".toDate, endDate: "30-06-2015".toDate)], workExperiences: [Experience(employee: "Synopsys", position: "Data Analyst", startDate: "01-10-2016".toDate, endDate: .now)], activities: [Activity(name: "Data Science Society", startYear: 2011, endYear: 2015)], certificates: [Certificate(providerName: "Udacity", yearOfProvision: 2020, name: "Data Scientist Nanodegree")], skills: ["R", "Python", "Tableau"], programs: [.empty(), .empty()], clubs: [.empty(), .empty()]),
        User(imageUrl: User.url, name: "Karen", surname: "Vardanyan", fatherName: "Artur", birthday: "10-12-1989".toDate, gender: .male, email: "karen.vardanyan@example.com", mobilePhone: "+37494456789", placeOfBirth: Address(country: "Armenia", region: "Lori", city: "Vanadzor"), currentResidence: Address(country: "Armenia", region: "Lori", city: "Vanadzor"), about: "Project manager with over 10 years of experience in the tech industry.", isSmartCitizen: true, universities: [University(name: "Vanadzor State University", faculty: "Engineering", department: "Electrical Engineering", startDate: "01-09-2007".toDate, endDate: "30-06-2011".toDate)], workExperiences: [Experience(employee: "Ucom", position: "Project Manager", startDate: "01-09-2012".toDate, endDate: .now)], activities: [Activity(name: "IEEE Student Branch", startYear: 2007, endYear: 2011)], certificates: [Certificate(providerName: "Project Management Institute", yearOfProvision: 2018, name: "PMP")], skills: ["Project Management", "Agile", "Scrum"], programs: [.empty(), .empty()], clubs: [.empty(), .empty()]),
        User(imageUrl: User.url, name: "Mariam", surname: "Petrosyan", fatherName: "Gevorg", birthday: "03-03-2000".toDate, gender: .female, email: "mariam.petrosyan@example.com", mobilePhone: "+37494567890", placeOfBirth: Address(country: "Armenia", region: "Gegharkunik", city: "Gavar"), currentResidence: Address(country: "Armenia", region: "Kotayk", city: "Hrazdan"), about: "Recent graduate with a degree in graphic design, eager to start a career in the creative industry.", isSmartCitizen: false, universities: [University(name: "National University of Architecture and Construction of Armenia", faculty: "Design", department: "Graphic Design", startDate: "01-09-2017".toDate, endDate: "30-06-2021".toDate)], workExperiences: [Experience(employee: "Freelance", position: "Graphic Designer", startDate: "01-07-2021".toDate, endDate: .now)], activities: [Activity(name: "Art Club", startYear: 2017, endYear: 2021)], certificates: [Certificate(providerName: "Adobe", yearOfProvision: 2021, name: "Adobe Certified Associate")], skills: ["Adobe Photoshop", "Illustrator", "InDesign"], programs: [.empty(), .empty()], clubs: [.empty(), .empty()]),
        User(imageUrl: User.url, name: "Davit", surname: "Arakelyan", fatherName: "Levon", birthday: "25-11-1992".toDate, gender: .male, email: "davit.arakelyan@example.com", mobilePhone: "+37494321098", placeOfBirth: Address(country: "Armenia", region: "Syunik", city: "Kapan"), currentResidence: Address(country: "Armenia", region: "Syunik", city: "Kapan"), about: "Mechanical engineer with a passion for robotics and automation.", isSmartCitizen: true, universities: [University(name: "National Polytechnic University of Armenia", faculty: "Engineering", department: "Mechanical Engineering", startDate: "01-09-2010".toDate, endDate: "30-06-2014".toDate)], workExperiences: [Experience(employee: "Armenian NPP", position: "Mechanical Engineer", startDate: "01-10-2015".toDate, endDate: .now)], activities: [Activity(name: "Robotics Club", startYear: 2010, endYear: 2014)], certificates: [Certificate(providerName: "Siemens", yearOfProvision: 2017, name: "Automation Engineer")], skills: ["CAD", "MATLAB", "Robotics"], programs: [.empty(), .empty()], clubs: [.empty(), .empty()]),
        User(imageUrl: User.url, name: "Narek", surname: "Babayan", fatherName: "Tigran", birthday: "14-02-1997".toDate, gender: .male, email: "narek.babayan@example.com", mobilePhone: "+37493210987", placeOfBirth: Address(country: "Armenia", region: "Tavush", city: "Dilijan"), currentResidence: Address(country: "Armenia", region: "Yerevan", city: "Yerevan"), about: "Software developer specializing in mobile app development for iOS and Android platforms.", isSmartCitizen: true, universities: [University(name: "Yerevan State University", faculty: "Informatics and Applied Mathematics", department: "Software Engineering", startDate: "01-09-2015".toDate, endDate: "30-06-2019".toDate)], workExperiences: [Experience(employee: "PicsArt", position: "Mobile Developer", startDate: "01-11-2019".toDate, endDate: .now)], activities: [Activity(name: "Hackathon Participant", startYear: 2015, endYear: 2019)], certificates: [Certificate(providerName: "Apple", yearOfProvision: 2020, name: "iOS Development")], skills: ["Swift", "Kotlin", "React Native"], programs: [.empty(), .empty()], clubs: [.empty(), .empty()]),
        
    ]
}

class MyProfileViewModel: ObservableObject {

    @Published var selectedTab: MyProfileTab
    @Published var user: User
            
    init(selectedTab: MyProfileTab = .aboutme, user: User = .init()) {
        self.selectedTab = selectedTab
        self.user = user
    }
    
}
