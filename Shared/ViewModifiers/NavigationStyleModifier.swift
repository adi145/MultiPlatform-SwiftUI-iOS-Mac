//
//  NavigationStyleModifier.swift
//  MoviesApp (iOS)
//
//  Created by Adinarayana-M on 9/3/2565 BE.
//

import SwiftUI

struct NavigationStyleModifier: ViewModifier {
    var isMacOS: Bool
    func body(content: Content) -> some View {
        Group {
            if isMacOS {
                content.navigationViewStyle(DefaultNavigationViewStyle())
            }else{
               #if os(iOS)
                content.navigationViewStyle(StackNavigationViewStyle())
               #endif
            }
        }
    }
}
