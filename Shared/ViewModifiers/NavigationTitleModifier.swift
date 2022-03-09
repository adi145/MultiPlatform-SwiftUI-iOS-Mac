//
//  NavigationTitleModifier.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 9/3/2565 BE.
//

import SwiftUI

struct NavigationTitleModifier: ViewModifier {
    var isBold: Bool
    var title: String
    func body(content: Content) -> some View {
        Group {
            if self.isBold {
                content.navigationTitle(Text(title))
            } else {
               #if os(iOS)
                content.navigationBarTitle(Text(title), displayMode: .inline)
                #endif
                #if os(tvOS)
                content.navigationTitle(Text(title))
                #endif
            }
        }
    }
}

