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
    @State var selectedCategory = ""
    var navigationItem : NavigationItem!
    @EnvironmentObject var settings : NavigationSettings
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    @State var gridColums: [GridItem] = []
    @Binding var selectedMovie: Movie
    @State var isShowMovieDetailsPage : Bool = false
    
    let columns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible()),
    ]
    
    func getCount() -> Int{
        if isMacOS(){
            return getRect().width > 1500 ? 7 : 5
        } else {
            #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 2 : 3 : orientationInfo.orientation == .portrait ? 3 : getRect().width > 1000 ? 5 : 4
            #endif
        }
        return 0
    }
    
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return getRect().width/5
        } else {
            #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-72)/3.5 : (getRect().height-92)/3.5
            : orientationInfo.orientation == .portrait ? (getRect().width-92)/5 : (getRect().height-92)/6
            #endif
        }
        return 0
    }
    
    fileprivate func displayAllMovies(movie: Movie) -> some View {
        return HStack {
            StandardHomeMovie(movie: movie).cornerRadius(5)
        }
        .frame(maxWidth: .infinity, minHeight: 80, idealHeight: 120 ,maxHeight: 150)
        .background(Color.black)
        .cornerRadius(5)
    }
    
    func getMainView() -> some View {
        vm.navigationItem = navigationItem
        return VStack{
            if isMacOS() {
                HeaderViewMac(title: "See more",onBackAction: backButton, isShowBackButton: true)
            }
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: getCount()), spacing: 10) {  // HERE 2
                    ForEach(vm.getMovie(forCat: selectedCategory), id: \.self) { movie in
                        if isMacOS() {
                            displayAllMovies(movie: movie)
                                .onTapGesture {
                                    self.selectedMovie = movie
                                    self.settings.selectedNavigationItem.append(.seeMore)
                                    self.isShowMovieDetailsPage = true
                                    self.settings.navigationItem = .moviesDetails
                                }
                        } else {
                            NavigationLink(destination: MovieDetailsView(selectedMovie: movie)){
                                displayAllMovies(movie: movie)
                            }
                        }
                    }
                }
                .padding([.leading,.trailing], 16)
            }.navigationTitle(Text(selectedCategory))
        }
    }
    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            VStack{
                getMainView()
            }
        }
        .onDisappear {
            if !isShowMovieDetailsPage {
                if self.settings.selectedNavigationItem.count > 0 {
                    self.settings.selectedNavigationItem.removeLast()
                }
            }
        }
    }
    
    func backButton() {
        self.settings.navigationItem = self.settings.selectedNavigationItem.last ?? .main
    }
}
