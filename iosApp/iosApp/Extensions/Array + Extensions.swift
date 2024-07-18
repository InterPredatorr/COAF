//
//  Array + Extensions.swift
//  iosApp
//
//  Created by Sevak on 18.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    mutating func updateItem<T: Equatable>(_ parameter: KeyPath<Element, T>, _ value: T, updateWith newValue: (inout Element) -> Void) {
        if let index = self.firstIndex(where: { $0[keyPath: parameter] == value }) {
            newValue(&self[index])
        }
    }
}
