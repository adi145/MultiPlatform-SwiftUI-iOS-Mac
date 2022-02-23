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
    @State var selectedMovie: Movie?
    @State var navigationItem: NavigationItem = .home
    @State var isHomeSelected: Bool = false
    @State var isFinderSelected: Bool = false
    @State var isDownloadsSelected: Bool = false
    @State var isMyStuffSelected: Bool = false
    
    @State var isShowHomeCarousel: Bool = false
    @State var isShowTVShowsCarousel: Bool = false
    @State var isShowMoviesCarousel: Bool = false
    @State var isShowKidsCarousel: Bool = false
    
    var vm = MoviesListViewModel()
    @State var topBannerItems: TopBannerItems = .home
    
    let titleStr: String = NSLocalizedString("Movies", comment: "")
    
    init() {
        if !isMacOS() {
            //Use this if NavigationBarTitle is with Large Font
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: ColorTheme.bgColor.color]
            //Use this if NavigationBarTitle is with displayMode = .inline
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }

    var navigateToMovieDetailsView : some View {
        NavigationLink(destination: MovieDetailsView(navigationItem: navigationItem), isActive: self.$settings.isNavigateMovieDetailsScreen) { EmptyView() }
    }
    
    var navigateToSeeMore : some View {
        NavigationLink(destination: SeeMoreView(selectedCategory:self.selectedCategory ?? "", navigationItem: navigationItem, selectedMovie: $selectedMovie), isActive: self.$settings.isNavigateSeeMorePage) { EmptyView() }
    }
    
    fileprivate func setupTopBannerView() -> some View {
        return VStack{
            switch topBannerItems {
            case .tvshows:
                TopBannerView(topBannerTems: topBannerItems).frame(width: isMacOS() ? nil: getRect().width, height: isMacOS() ? nil: getRect().width/2.5).padding(.bottom, 20)
            case .movies:
                TopBannerView(topBannerTems: topBannerItems).frame(width: isMacOS() ? nil: getRect().width, height: isMacOS() ? nil: getRect().width/2.5).padding(.bottom, 20)
            case .kids:
                TopBannerView(topBannerTems: topBannerItems).frame(width: isMacOS() ? nil: getRect().width, height: isMacOS() ? nil: getRect().width/2.5).padding(.bottom, 20)
            default:
                TopBannerView(topBannerTems: topBannerItems).frame(width: isMacOS() ? nil: getRect().width, height: isMacOS() ? nil: getRect().width/2.5).padding(.bottom, 20)
            }
        }
    }
    
    fileprivate func mainView(navigationItem:NavigationItem) -> some View {
        vm.navigationItem = navigationItem
        return ScrollView(showsIndicators: false) {
            setupTopBannerView()
            LazyVStack {
                ForEach(vm.allHomeMoviesCategories, id: \.self) { category in
                    VStack {
                        HStack {
                            Text(category)
                                .font(.system(size: isMacOS() ? 20 : 16))
                                .fontWeight(.bold)
                                .bold().padding(.leading, 10)
                            Image(systemName: "chevron.right")
                            Spacer()
                        }.foregroundColor(.white)
                            .onTapGesture {
                                self.selectedCategory = category
                                if isMacOS() {
                                self.settings.navigationItem = NavigationItem.seeMore
                                } else {
                                    self.settings.isNavigateSeeMorePage = true
                                }
                            }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(vm.getMovie(forCat: category)) { movie in
                                    StandardHomeMovie(movie: movie)
                                        .frame(width: isMacOS() ? 150 : (getRect().width-72)/2, height: isMacOS() ? 150 : (getRect().width-72)/3.5)
                                        .cornerRadius(5)
                                        .padding(.horizontal, 0).onTapGesture {
                                            self.selectedMovie = movie
                                            if isMacOS() {
                                            self.settings.navigationItem = NavigationItem.moviesDetails
                                            } else {
                                                self.settings.isNavigateMovieDetailsScreen = true
                                            }
                                        }
                                }
                            }
                        }
                    }.foregroundColor(.white)
                }
            }
        }.padding([.leading, .trailing], isMacOS() ? 25 : 16)
    }
    
    fileprivate func showHeaderAndToolBar(navigationItem: NavigationItem) -> some View{
        return VStack {
            if isMacOS() {
                HeaderViewMac(title: titleStr)
            }
            TopToolBarView(isShowHomeCarousel: $isShowHomeCarousel, isShowTVShowsCarousel: $isShowTVShowsCarousel, isShowMoviesCarousel: $isShowMoviesCarousel, isShowKidsCarousel: $isShowKidsCarousel, topBannerItems: $topBannerItems)
            navigateToMovieDetailsView
            navigateToSeeMore
            mainView(navigationItem: navigationItem)
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
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
                    SeeMoreView(vm: MoviesListViewModel(), selectedCategory: selectedCategory ?? "", navigationItem: self.settings.navigationItem, selectedMovie: $selectedMovie)
                        .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
                        .background(Color.white)
                case .moviesDetails:
                    MovieDetailsView(navigationItem: self.settings.navigationItem, movie: selectedMovie)
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
                
        }.background(ColorTheme.bgColor.color)
            .navigationBarTitle(Text(titleStr), displayMode: .inline)
            .navigationBarHidden(false)
    }
}
