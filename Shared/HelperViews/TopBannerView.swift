//
//  TopBannerView.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 22/2/2565 BE.
//

import SwiftUI

struct TopBannerView: View {
    @State private var selectedPage = 0
    var vm = MoviesListViewModel()
    var topBannerTems: TopBannerItems = .home
    var navigationItem: NavigationItem = .home
    @EnvironmentObject var settings : NavigationSettings
    
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    @State var selectedMovie: Movie?
    
    fileprivate func displayMoviesWithHorizontal(movie: Movie) -> some View {
        return StandardHomeMovie(movie: movie)
            .frame(width: getMovieItemWidth() , height: getMovieItemHeight())
            .cornerRadius(10)
            .padding(.horizontal, 5)
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(vm.getTopbannerList(topBannerItems: topBannerTems)) { movie in
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
                }.cornerRadius(10)
            }
        }.frame(width: isMacOS() ? getRect().width-32 : getRect().width-32, height: getMovieItemHeight() ).padding(.bottom, 20)
            .cornerRadius(10)
        
    }
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return (getRect().width-32)/7
        } else {
          #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width)/1.9 : (getRect().height)/1.9 : orientationInfo.orientation == .portrait ? (getRect().width)/4 : (getRect().height)/3.5
          #endif
        }
        return 0
    }
    
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return (getRect().width-32)/4.2
        } else {
          #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-62) :  (getRect().width-72)/2 : orientationInfo.orientation == .portrait ? (getRect().width-82)/2 :  (getRect().width-82)/2
          #endif
        }
        return 0
    }
}

struct TopBannerView_Previews: PreviewProvider {
    static var previews: some View {
        TopBannerView()
    }
}
