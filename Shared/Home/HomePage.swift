//
//  TabView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

enum NavigationItem {
    case home
    case search
    case downloads
    case mystuff
    case moviesDetails
    case seeMore
    case find
    case myStuff
}

struct HomePage: View {
    var body: some View {
        TabViewPage()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
