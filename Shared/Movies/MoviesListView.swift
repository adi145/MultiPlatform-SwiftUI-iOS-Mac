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
    @State var navigationItem: NavigationItem = .home
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
    
    fileprivate func setupTopBannerView() -> some View {
        return VStack{
            TopBannerView(topBannerTems: topBannerItems)
        }
    }
    
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return 150
        } else {
            #if os(iOS)
            return orientationInfo.orientation == .portrait ? (getRect().width-72)/3.5 : (getRect().height-92)/3.5
            #endif
        }
    }
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return 150
        } else {
            #if os(iOS)
            return orientationInfo.orientation == .portrait ? (getRect().width-72)/2 :  (getRect().height-92)/2
            #endif
        }
    }
    func getTopBannerview() -> some View {
        return VStack {
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
    
    
    fileprivate func mainView(navigationItem:NavigationItem) -> some View {
        vm.navigationItem = navigationItem
        return ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(vm.allHomeMoviesCategories, id: \.self) { category in
                    if category == TopBannerItems.home.rawValue
                        || category == TopBannerItems.movies.rawValue
                        || category == TopBannerItems.kids.rawValue
                        || category == TopBannerItems.tvshows.rawValue
                        || category == TopBannerItems.featuredMovies.rawValue {
                        getTopBannerview()
                    } else {
                        VStack {
                            NavigationLink(destination: SeeMoreView(selectedCategory:category , navigationItem:navigationItem)){
                                HStack {
                                    Text(category)
                                        .font(.system(size: isMacOS() ? 20 : 16))
                                        .fontWeight(.bold)
                                        .bold().padding(.leading, 10)
                                    Image(systemName: "chevron.right")
                                    Spacer()
                                }.foregroundColor(.white)
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack {
                                    ForEach(vm.getMovie(forCat: category)) { movie in
                                        NavigationLink(destination: MovieDetailsView(navigationItem: navigationItem, selectedMovie: movie)){
                                            StandardHomeMovie(movie: movie)
                                                .frame(width: getMovieItemWidth() , height: getMovieItemHeight())
                                                .cornerRadius(5)
                                                .padding(.horizontal, 0)
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
    
    fileprivate func showHeaderAndToolBar(navigationItem: NavigationItem) -> some View{
        return VStack {
            if isMacOS() {
                HeaderViewMac(title: titleStr)
            }
            TopToolBarView(isShowHomeCarousel: $isShowHomeCarousel, isShowTVShowsCarousel: $isShowTVShowsCarousel, isShowMoviesCarousel: $isShowMoviesCarousel, isShowKidsCarousel: $isShowKidsCarousel, topBannerItems: $topBannerItems)
            mainView(navigationItem: navigationItem)
        }
    }
    
    var body: some View {
        NavigationView {
            Group{
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
                        SeeMoreView()
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
            }.background(ColorTheme.bgColor.color)
                .conditionalView(isMacOS() ? true : false, title: titleStr)
        }
    }
}
