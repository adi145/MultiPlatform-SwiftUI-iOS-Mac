//
//  GemListViewer.swift
//  MoviesApp (macOS)
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

struct TabViewPage: View {
    @State var moviesNavigation = NavigationItem.home
    @State var selectedCategory: String?
    @State var selectedMovie: Movie?

    var body: some View {
        VStack{
            switch moviesNavigation {
            case .find:
                SearchView(moviesNavigation: $moviesNavigation).frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            case .downloads:
                DownloadView(moviesNavigation: $moviesNavigation).frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            case .mystuff:
                MyStuffView(moviesNavigation: $moviesNavigation)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            case .seeMore:
                AllMoviesListView(vm: MoviesListViewModel(), selectedCategory: selectedCategory ?? "", moviesNavigation: $moviesNavigation, selectedMovie: $selectedMovie)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            case .moviesDetails:
                MovieDetailsView(moviesNavigation: $moviesNavigation, movie: selectedMovie)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                        makeWindow()
                    })
//                    .transition(AnyTransition.move(edge: .trailing)).animation(.default)
            default:
                MoviesListView(moviesNavigation: $moviesNavigation, selectedCategory: $selectedCategory, selectedMovie: $selectedMovie)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
//                    .transition(AnyTransition.move(edge: .leading)).animation(.default)
            }
        }
    }
  }

struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}
 
