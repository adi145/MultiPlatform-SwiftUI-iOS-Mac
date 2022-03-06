//
//  MoviesTVAppApp.swift
//  MoviesTVApp
//
//  Created by Adinarayana-M on 27/2/2565 BE.
//

import SwiftUI
//import MoviesApp

@main
struct MoviesTVAppApp: App {
    let userSettings = NavigationSettings()

    var body: some Scene {
        WindowGroup {
            MoviesListView().environmentObject(userSettings)
        }
    }
}
