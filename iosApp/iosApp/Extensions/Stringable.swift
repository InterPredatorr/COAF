//
//  Stringable.swift
//  iosApp
//
//  Created by Sevak on 20.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

protocol Stringable {
    var stringValue: String { get }
}

extension String: Stringable {
    var stringValue: String {
        self.capitalized
    }    
}

extension Gender: Stringable {
    var stringValue: String {
        self.name.lowercased().capitalized
    }
}

extension CoafClubPosition: Stringable {
    var stringValue: String {
        self.name.lowercased().capitalized
    }
}
