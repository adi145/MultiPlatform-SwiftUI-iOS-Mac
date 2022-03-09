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
    @State var selectedCategory: String
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
    
    @State var findNavigationItem: NavigationItem
    
    
#if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
#endif
    var vm = MoviesListViewModel()
    let titleStr: String = NSLocalizedString("Movies", comment: "")
    
    fileprivate func moviesList(navigationItem: NavigationItem) -> some View {
        return MoviesHome(title: titleStr, navigationItem: navigationItem, selectedMovie: $selectedMovie, selectedCategory: $selectedCategory).onAppear {
            self.navigationItem = navigationItem
            vm.navigationItem = navigationItem
        }
    }
    
    @ViewBuilder
    func showHeaderAndToolBar(navigationItem: NavigationItem) -> some View{
        VStack {
            if isMacOS() {
                HeaderViewMac(title: titleStr)
            }
            TopToolBarView(isShowHomeCarousel: $isShowHomeCarousel, isShowTVShowsCarousel: $isShowTVShowsCarousel, isShowMoviesCarousel: $isShowMoviesCarousel, isShowKidsCarousel: $isShowKidsCarousel)
            moviesList(navigationItem: navigationItem)
        }
    }
    
    
    @ViewBuilder
    func setupView() -> some View {
        VStack{
            switch settings.navigationItem {
            case .find:
                FinderView(findNavigationItem: $findNavigationItem, selectedCategory: $selectedCategory)
                    .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
            case .downloads:
                DownloadView()
                    .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
            case .mystuff:
                MyStuffView()
                    .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
            case .seeMore:
                SeeMoreView(selectedCategory: self.selectedCategory, navigationItem:findNavigationItem, selectedMovie: $selectedMovie)
                    .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
            case .moviesDetails:
                MovieDetailsView(selectedMovie: selectedMovie)
                    .frame(maxWidth: isMacOS() ? getRect().width : nil, maxHeight: isMacOS() ? getRect().height : nil)
            case .home:
                showHeaderAndToolBar(navigationItem: .home)
            case .movies:
                showHeaderAndToolBar(navigationItem: .movies)
            case .TV:
                showHeaderAndToolBar(navigationItem: .TV)
            case .kids:
                showHeaderAndToolBar(navigationItem: .kids)
            case .main:
                showHeaderAndToolBar(navigationItem: .main)
            }
            if isMacOS() {
                BottomToolBarBottons(isHomeSelected: $isHomeSelected, isFinderSelected: $isFinderSelected, isDownloadsSelected: $isDownloadsSelected, isMyStuffSelected: $isMyStuffSelected)
            }
        }.background(ColorTheme.bgColor.color)
    }
    
    var body: some View {
        NavigationView {
            setupView()
                .conditionalNavigationTitle(isMacOS() ? true : false, title: titleStr)
        }.conditionalNavigationStyle(isMacOS())
    }
}
