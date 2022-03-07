//
//  ContentView.swift
//  Shared
//
//  Created by Adinarayana on 15/02/22.
//

import SwiftUI
import Kingfisher
import AVFoundation


struct MoviesListView: View {
    
    @EnvironmentObject var settings : NavigationSettings
    @State var selectedCategory: String?
    @State var selectedMovie: Movie = Movie()
    @State var navigationItem: NavigationItem
    @State var isHomeSelected: Bool = false
    @State var isFinderSelected: Bool = false
    @State var isDownloadsSelected: Bool = false
    @State var isMyStuffSelected: Bool = false
    @State var isShowHomeCarousel: Bool = false
    @State var isShowTVShowsCarousel: Bool = false
    @State var isShowMoviesCarousel: Bool = false
    @State var isShowKidsCarousel: Bool = false
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
     #endif
    var vm = MoviesListViewModel()
    @State var topBannerItems: TopBannerItems = .home
    
    let titleStr: String = NSLocalizedString("Movies", comment: "")
    
    func getSelecteMovieInfo() -> Movie {
        return self.selectedMovie
    }
    
    @ViewBuilder
    func setupTopBannerView() -> some View {
        VStack{
            TopBannerView(topBannerTems: topBannerItems)
        }
    }
    
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return getRect().width/12
        } else {
            #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-72)/3.5 : (getRect().height-92)/3.5
            : orientationInfo.orientation == .portrait ? (getRect().width-92)/5 : (getRect().height-92)/6
            #endif
        }
        return 0
    }
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return getRect().width/6
        } else {
            #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-92)/2 :  (getRect().height-92)/2
            : orientationInfo.orientation == .portrait ? (getRect().width-102)/3 :  (getRect().height-92)/3.5
            #endif
        }
        return 0
    }
   
    @ViewBuilder
    func getTopBannerview() -> some View {
        LazyVStack {
            switch topBannerItems {
            case .home:
                TopBannerView(topBannerTems: .home)
            case .tvshows:
                TopBannerView(topBannerTems: .tvshows)
            case .movies:
                TopBannerView(topBannerTems: .movies)
            case .kids:
                TopBannerView(topBannerTems: .kids)
            case .featuredMovies:
                TopBannerView(topBannerTems: .featuredMovies)
            }
        }
    }
    
    @ViewBuilder
    func displayCategoryView(category: String) -> some View {
        HStack {
            Text(category)
                .font(.system(size: isMacOS() ? 20 : 16))
                .fontWeight(.bold)
                .bold().padding(.leading, 10)
            Image(systemName: "chevron.right")
            Spacer()
        }.foregroundColor(.white)
    }
    
    @ViewBuilder
    func displayMoviesWithHorizontal(movie: Movie) -> some View {
        StandardHomeMovie(movie: movie)
            .frame(width: getMovieItemWidth() , height: getMovieItemHeight())
            .cornerRadius(5)
            .padding(.horizontal, 5)
    }
    
    fileprivate func moviesList(navigationItem:NavigationItem) -> some View {
        vm.navigationItem = navigationItem
        return ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(vm.allHomeMoviesCategories, id: \.self) { category in
                    if category == TopBannerItems.home.rawValue {
                        getTopBannerview()
                    } else if category == TopBannerItems.featuredMovies.rawValue {
                        LazyVStack {
                            displayCategoryView(category: category).padding([.leading,.trailing], 16)
                            getTopBannerview()
                        }
                    } else {
                        LazyVStack {
                            if isMacOS() {
                                displayCategoryView(category: category)
                                    .onTapGesture {
                                        self.selectedCategory = category
                                        self.settings.selectedNavigationItem.append(.home)
                                        self.settings.navigationItem = NavigationItem.seeMore
                                    }
                            } else {
                                NavigationLink(destination: SeeMoreView(selectedCategory:category , navigationItem:navigationItem, selectedMovie: $selectedMovie)){
                                    displayCategoryView(category: category)
                                }
                            }
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(vm.getMovie(forCat: category)) { movie in
                                        if isMacOS() {
                                            displayMoviesWithHorizontal(movie: movie)
                                                .onTapGesture {
                                                self.selectedMovie = movie
                                                self.settings.selectedNavigationItem.append(.home)
                                                self.settings.navigationItem = NavigationItem.moviesDetails
                                            }
                                        } else {
                                            NavigationLink(destination: MovieDetailsView(navigationItem: navigationItem, selectedMovie: movie)){
                                                displayMoviesWithHorizontal(movie: movie)
                                            }
                                        }
                                    }
                                }
                            }
                        }.foregroundColor(.white)
                            .padding([.leading,.trailing], 16)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func showHeaderAndToolBar(navigationItem: NavigationItem) -> some View{
         VStack {
            if isMacOS() {
                HeaderViewMac(title: titleStr)
            }
            TopToolBarView(isShowHomeCarousel: $isShowHomeCarousel, isShowTVShowsCarousel: $isShowTVShowsCarousel, isShowMoviesCarousel: $isShowMoviesCarousel, isShowKidsCarousel: $isShowKidsCarousel, topBannerItems: $topBannerItems)
            moviesList(navigationItem: navigationItem)
        }
    }
    
   
   @ViewBuilder
   func setupView() -> some View {
        VStack{
            switch settings.navigationItem {
            case .find:
                FinderView().frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
                    .background(Color.white)
            case .downloads:
                DownloadView().frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
                    .background(Color.white)
            case .mystuff:
                MyStuffView()
                    .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
                    .background(Color.white)
            case .seeMore:
                SeeMoreView(selectedCategory: self.selectedCategory ?? "", navigationItem: self.navigationItem, selectedMovie: $selectedMovie)
                    .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
                    .background(Color.white)
            case .moviesDetails:
                MovieDetailsView(navigationItem: self.settings.navigationItem, selectedMovie: selectedMovie)
                    .background(Color.white)
            case .toolBarHome, .toolBarMovies:
                showHeaderAndToolBar(navigationItem: .home)
            case .toolBarTvShows:
                showHeaderAndToolBar(navigationItem: .toolBarTvShows)
            case .toolBarKids:
                showHeaderAndToolBar(navigationItem: .toolBarKids)
            default:
                showHeaderAndToolBar(navigationItem: .home)
            }
            if isMacOS() {
                BottomToolBarBottons(isHomeSelected: $isHomeSelected, isFinderSelected: $isFinderSelected, isDownloadsSelected: $isDownloadsSelected, isMyStuffSelected: $isMyStuffSelected)
            }
        }.background(ColorTheme.bgColor.color)
    }
    
    var body: some View {
       NavigationView {
            Group{
                setupView()
            }.background(ColorTheme.bgColor.color)
                .conditionalView(isMacOS() ? true : false, title: titleStr)
       }.conditionalNavigationStyle(isMacOS())
    }
}
