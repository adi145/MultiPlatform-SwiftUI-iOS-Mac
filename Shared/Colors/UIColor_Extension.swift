//
//  UIColor_Extension.swift
//  MoviesApp
//
//  Created by Adinarayana on 20/02/22.
//

import Foundation
import SwiftUI

enum ColorTheme {
    case bgColor
    case customGreen
    case customBlue

    var color: Color {
        switch self {
        case .bgColor:
            return Color(red: 13.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, opacity: 1.0)
        case .customGreen:
            return Color(red: 13.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, opacity: 1.0)
        case .customBlue:
            return Color(red: 13.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, opacity: 1.0)
        }
    }
}
