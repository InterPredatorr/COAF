//
//  DS.swift
//  iosApp
//
//  Created by Sevak Tadevosyan on 19.05.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct DS {
    static var headerImage: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Image(.coafMain)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 60)
        }
    }
}
