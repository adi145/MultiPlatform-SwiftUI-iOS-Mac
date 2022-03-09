//
//  View+Extensions.swift
//  MoviesApp (iOS)
//
//  Created by Adinarayana-M on 27/2/2565 BE.
//

import SwiftUI

extension View {
    
    func conditionalNavigationTitle(_ value: Bool, title:String) -> some View {
        self.modifier(NavigationTitleModifier(isBold: value, title: title))
    }
    
    func conditionalNavigationStyle(_ value: Bool) -> some View {
        self.modifier(NavigationStyleModifier(isMacOS: value))
    }
    
    func getRect() -> CGRect {
       #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds
       #else
        return CGRect(x: 0, y: 0, width: 1500, height: 800)
        //        return NSScreen.main!.visibleFrame
       #endif
    }
    
    func isMacOS() -> Bool {
        #if os(iOS)
        return false
        #endif
        return true
    }
    
    func isTVOS() -> Bool {
        #if os(tvOS)
        return true
        #endif
        return false
    }
}
