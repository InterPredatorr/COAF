//
//  PeopleViewModel.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 19.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

struct Filter {
    var text: String
    var gender: Gender
    var region: String
    var education: Education
    
    static let empty = Self(text: "", gender: .other, region: "", education: .companion.empty())
}


class PeopleViewModel: ObservableObject {
    
    
    @Published var persons: [User] = []
    @Published var filter: Filter = .empty
    var users = User.companion.users()
}
