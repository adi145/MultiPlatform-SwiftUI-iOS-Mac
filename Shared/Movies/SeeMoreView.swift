//
//  AllMoviesListView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI
import Kingfisher

struct SeeMoreView: View {
    var vm = MoviesListViewModel()
    var selectedCategory = "Top movies"
    var navigationItem : NavigationItem!
    @EnvironmentObject var settings : NavigationSettings
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    @State var gridColums: [GridItem] = []
    @Binding var selectedMovie: Movie
    @State var selectedMovie1: Movie = Movie()

    let columns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible()),
    ]
    
    func getCount() -> Int{
        if isMacOS(){
            return 5
        } else {
           #if os(iOS)
            return orientationInfo.orientation == .portrait ? 2 : 3
           #endif
        }
        return 0
    }
    
    fileprivate func displayAllMovies(movie: Movie) -> some View {
        return HStack {
            StandardHomeMovie(movie: movie).cornerRadius(2)
        }
        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100)
        .background(Color.black)
        .cornerRadius(5)
    }
    
    func getMainView() -> some View {
        return VStack{
            if isMacOS(){
                HeaderViewMac(title: "See more",onBackAction: backButton, isShowBackButton: true)
            }
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: getCount()), spacing: 10) {  // HERE 2
                    ForEach((vm.getMovie(forCat: selectedCategory))) { movie in
                        if isMacOS() {
                            displayAllMovies(movie: movie)
                                .onTapGesture {
                                    self.selectedMovie = movie
                                    self.selectedMovie1 = movie
                                    //                                        self.settings.selectedNavigationItem.append(.seeMore)
                                    self.settings.isFromSeeMoreToMovieDetailsScreen = true
                                }
                        } else {
                            NavigationLink(destination: MovieDetailsView(navigationItem: navigationItem, selectedMovie: movie)){
                                displayAllMovies(movie: movie)
                            }
                        }
                        
                    }
                }
                .padding([.leading,.trailing], 16)
            }.navigationTitle(Text("Seemore"))
        }
    }
    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            VStack{
                switch self.settings.navigationItem {
                case .moviesDetails:
                    MovieDetailsView(navigationItem: self.settings.navigationItem)
                default:
                    getMainView()
                }
            }
        }.background(.orange)
    }
    
    var navigateToMovieDetailsView : some View {
        NavigationLink(destination: MovieDetailsView(navigationItem: navigationItem), isActive: self.$settings.isNavigateMovieDetailsScreen) { EmptyView() }
    }
    
    func backButton() {
        settings.navigationItem = .home
    }
}
