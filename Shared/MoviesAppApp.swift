//
//  MoviesAppApp.swift
//  Shared
//
//  Created by Adinarayana on 15/02/22.
//

import SwiftUI

@main
struct MoviesAppApp: App {
    let userSettings = NavigationSettings()
    
    var body: some Scene {
       #if os(macOS)
        WindowGroup {
            HomePage()
                .environmentObject(userSettings)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                    makeWindow()
                })
        }
        .commands {
            CommandGroup(replacing: .newItem, addition: {
            })
        }
        #endif
       #if os(iOS)
        WindowGroup {
            HomePage()
                .environmentObject(userSettings)
                .environmentObject(OrientationInfo())
        }
       #endif
    }
    func makeWindow() {
        #if os(macOS)
        for window in NSApplication.shared.windows {
            window.titleVisibility = .hidden
            window.titlebarAppearsTransparent = true
            window.backgroundColor = NSColor.black
            window.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
            window.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = false
            window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = false
        }
       #endif
    }
}

