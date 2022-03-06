//
//  View+Extensions.swift
//  MoviesApp (iOS)
//
//  Created by Adinarayana-M on 27/2/2565 BE.
//

import SwiftUI

extension View {
    func getRect() -> CGRect {
       #if os(iOS) || os(tvOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main!.visibleFrame
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
