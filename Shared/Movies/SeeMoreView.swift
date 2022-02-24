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
    @State var selectedMovie: Movie?
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
    
    func getMainView() -> some View {
        return VStack{
            if isMacOS(){
                HeaderViewMac(title: "See more",onBackAction: backButton, isShowBackButton: true)
            }
            if !isMacOS(){
                navigateToMovieDetailsView
            }
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5, alignment: .center), count: getCount()), spacing: 5) {  // HERE 2
                    ForEach((vm.getMovie(forCat: selectedCategory))) { movie in
                        HStack {
                            StandardHomeMovie(movie: movie).cornerRadius(2)
                        }
                        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100) // HERE 1
                        .background(Color.black)
                        .cornerRadius(1)
                        .onTapGesture {
                            self.selectedMovie = movie
                            if isMacOS() {
                                self.settings.selectedNavigationItem.append(.seeMore)
                                self.settings.navigationItem = NavigationItem.moviesDetails
                            } else {
                                self.settings.isNavigateMovieDetailsScreen = true
                            }
                        }
                    }
                }
                .padding(0)
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
        self.settings.navigationItem = .home
    }
}

struct AllMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeeMoreView()
    }
}
