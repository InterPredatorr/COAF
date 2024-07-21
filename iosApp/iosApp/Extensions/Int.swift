//
//  Int.swift
//  iosApp
//
//  Created by Sevak on 21.07.24.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

extension Int {
    var toLocalDateMonth: Kotlinx_datetimeMonth {
        return switch self {
            case 1:
                .january
            case 2:
                .february
            case 3:
                .march
            case 4:
                .april
            case 5:
                .may
            case 6:
                .june
            case 7:
                .july
            case 8:
                .august
            case 9:
                .september
            case 10:
                .october
            case 11:
                .november
            case 12:
                .december
            default:
                .january
        }
    }
}
