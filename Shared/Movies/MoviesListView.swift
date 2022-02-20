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

    let titleStr: String = NSLocalizedString("Movies", comment: "")
    let homeStr: String = NSLocalizedString("Home", comment: "")
    let findStr: String = NSLocalizedString("Find", comment: "")
    let downloadStr: String = NSLocalizedString("Downloads", comment: "")
    let myStuffStr: String = NSLocalizedString("MyStuff", comment: "")

    fileprivate func mainView(navigationItem:NavigationItem) -> some View {
        vm.navigationItem = navigationItem
        return ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(vm.allHomeMoviesCategories, id: \.self) { category in
                    VStack {
                        HStack {
                            Text(category)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .bold().padding(.leading, 10)
                            Image(systemName: "chevron.right")
                            Spacer()
                        }.foregroundColor(.white)
                            .onTapGesture {
                                self.selectedCategory = category
                                self.settings.navigationItem = NavigationItem.seeMore
                            }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(vm.getMovie(forCat: category)) { movie in
                                    StandardHomeMovie(movie: movie)
                                        .frame(width: 150, height: 200)
                                        .padding(.horizontal, 5).onTapGesture {
                                            self.selectedMovie = movie
                                            self.settings.navigationItem = NavigationItem.moviesDetails
                                        }
                                }
                            }
                        }
                    }.foregroundColor(.white)
                }
            }
        }.padding([.leading, .trailing], 25)
    }
    
    fileprivate func topToolBarButonsWithCarsouals() -> some View {
        return VStack{
            HStack(spacing:0){
                Button("Home") {
                    isShowTVShowsCarousel = false
                    isShowMoviesCarousel = false
                    isShowKidsCarousel = false
                    isShowHomeCarousel = true
                    self.settings.navigationItem = .toolBarHome
                }.frame(width: 120, height: 38)
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                
                Button("TV Shows") {
                    isShowTVShowsCarousel = true
                    isShowMoviesCarousel = false
                    isShowKidsCarousel = false
                    isShowHomeCarousel = false
                    self.settings.navigationItem = .toolBarTvShows
                }.frame(width: 120, height: 38)
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                
                Button("Movies") {
                    isShowTVShowsCarousel = false
                    isShowMoviesCarousel = true
                    isShowKidsCarousel = false
                    isShowHomeCarousel = false
                    self.settings.navigationItem = .toolBarMovies
                }.frame(width: 120, height: 38)
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                
                Button("Kids") {
                    isShowTVShowsCarousel = false
                    isShowMoviesCarousel = false
                    isShowKidsCarousel = true
                    isShowHomeCarousel = false
                    self.settings.navigationItem = .toolBarKids
                }.frame(width: 100, height: 38, alignment: .center)
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                
            }.frame(width: 460, height: 38, alignment: .center)
                .background(.clear)
            
            HStack(){
                if isShowHomeCarousel{
                    Spacer().frame(width: 90, height: 2, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: 120, height: 2, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
                
                if isShowTVShowsCarousel{
                    Spacer().frame(width: 100, height: 2, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: 120, height: 2, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
                
                if isShowMoviesCarousel{
                    Spacer().frame(width: 90, height: 2, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: 120, height: 2, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
                if isShowKidsCarousel{
                    Spacer().frame(width: 80, height: 2, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: 100, height: 2, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
            }.frame(width: 460, height: 2, alignment: .center)
                .background(.clear)
                .padding([.leading,.trailing],0)
            
        }.frame(width: 460, height: 40, alignment: .center)
            .background(.clear)
    }
    
    func bottomToolBarView() -> some View{
       return VStack{
            HStack{
                Spacer()
                Button(action: homeAction) {
                    Label(homeStr, systemImage: "house.fill")
                        .foregroundColor(isHomeSelected ? .blue : .gray)
                        .font(.system(size: 18))
                }.buttonStyle(.plain)
                Spacer()
                
                Button(action: findAction) {
                    Label(findStr, systemImage: "magnifyingglass")
                        .foregroundColor(isFinderSelected ? .blue : .gray)
                        .font(.system(size: 18))

                }.buttonStyle(.plain)
    
                Spacer()
                Button(action: downloadAction) {
                    Label(downloadStr, systemImage: "arrow.down.circle")
                        .foregroundColor(isDownloadsSelected ? .blue : .gray)
                        .font(.system(size: 18))

                }.buttonStyle(.plain)
                Spacer()
                Button(action: myStuffAction) {
                    Label(myStuffStr, systemImage: "person.circle.fill")
                        .foregroundColor(isMyStuffSelected ? .blue : .gray)
                        .font(.system(size: 18))
                }.buttonStyle(.plain)
                Spacer()
            }.frame(width: isMacOS() ? getRect().width : nil , height: 40, alignment: .center)
        }.frame(width: isMacOS() ? getRect().width : nil , height: 40, alignment: .center)
            .background(.black)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
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
//                        .transition(AnyTransition.move(edge: .trailing)).withAnimation(.default)
                case .moviesDetails:
                    MovieDetailsView(navigationItem: self.settings.navigationItem, movie: selectedMovie)
                        .background(Color.white)
//                        .transition(AnyTransition.move(edge: .trailing)).animation(.default)
                case .toolBarHome, .toolBarMovies:
                    HeaderViewMac(title: titleStr)
                    topToolBarButonsWithCarsouals()
                    mainView(navigationItem: .toolBarHome)
                case .toolBarTvShows:
                    HeaderViewMac(title: titleStr)
                    topToolBarButonsWithCarsouals()
                    mainView(navigationItem: .toolBarTvShows)
//                case .toolBarMovies:
//                    mainView(navigationItem: .toolBarMovies)
                case .toolBarKids:
                    HeaderViewMac(title: titleStr)
                    topToolBarButonsWithCarsouals()
                    mainView(navigationItem: .toolBarKids)
                default:
                    HeaderViewMac(title: titleStr)
                    topToolBarButonsWithCarsouals()
                    mainView(navigationItem: .home)
                }
                bottomToolBarView()
            }.background(ColorTheme.bgColor.color)
        }.background(ColorTheme.bgColor.color)
            .onAppear(){
                homeAction()
            }
    }
    
    func homeAction() {
        self.isHomeSelected = true
        self.isFinderSelected = false
        self.isDownloadsSelected = false
        self.isMyStuffSelected = false
        self.settings.navigationItem = .home
    }
    func findAction() {
        self.isHomeSelected = false
        self.isFinderSelected = true
        self.isDownloadsSelected = false
        self.isMyStuffSelected = false
        self.settings.navigationItem = .find
    }
    func downloadAction() {
        self.isHomeSelected = false
        self.isFinderSelected = false
        self.isDownloadsSelected = true
        self.isMyStuffSelected = false
        self.settings.navigationItem = .downloads
    }
    func myStuffAction() {
        self.isHomeSelected = false
        self.isFinderSelected = false
        self.isDownloadsSelected = false
        self.isMyStuffSelected = true
        self.settings.navigationItem = .mystuff
    }
}
