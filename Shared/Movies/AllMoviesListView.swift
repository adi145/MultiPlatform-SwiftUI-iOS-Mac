//
//  AllMoviesListView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

struct AllMoviesListView: View {
    var vm = MoviesListViewModel()
    var selectedCategory = ""
    @Binding var moviesNavigation: NavigationItem
    @Binding var selectedMovie: Movie?
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.getMovie(forCat: selectedCategory)) { movie in
                        StandardHomeMovie(movie: movie)
                            .frame(width: 125, height: 200)
                            .padding(.horizontal, 10)
                            .onTapGesture {
                                self.selectedMovie = movie
                                self.moviesNavigation = .moviesDetails
                            }
                    }
                }
            }
        }.toolbar {
            ToolbarItem {
                Button(action: backButton) {
                    Label("", systemImage: "chevron.left")
                }
            }
        }
    }
    
    func backButton() {
        moviesNavigation = .home
    }
}
//
//struct AllMoviesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllMoviesListView()
//    }
//}
