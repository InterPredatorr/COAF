//
//  Stringable.swift
//  iosApp
//
//  Created by Sevak on 20.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

protocol Stringable {
    var toString: String { get }
}

extension String: Stringable {
    var toString: String { self.capitalized }
}
extension Date: Stringable {
    var toString: String { self.stringValue.capitalized }
}
