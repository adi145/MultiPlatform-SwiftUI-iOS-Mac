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
    
    var navigateToMovieDetailsView : some View {
        NavigationLink(destination: MovieDetailsView(navigationItem: navigationItem), isActive: self.$settings.isNavigateMovieDetailsScreen) { EmptyView() }
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(vm.getTopbannerList(topBannerItems: topBannerTems)) { movie in
                        NavigationLink(destination: MovieDetailsView(navigationItem: navigationItem, selectedMovie: movie)){
                            StandardHomeMovie(movie: movie)
                                .frame(width: getMovieItemWidth() , height: getMovieItemHeight())
                                .cornerRadius(10)
                                .padding(.horizontal, 5)
                           }
                    }
                }.cornerRadius(10)
            }
        }.frame(width: isMacOS() ? nil: getRect().width, height: getMovieItemHeight() ).padding(.bottom, 20)
    }
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return getRect().width/7
        } else {
          #if os(iOS)
            return orientationInfo.orientation == .portrait ? (getRect().width)/1.9 : (getRect().height)/1.9
          #endif
        }
        return 0
    }
    
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return getRect().width/5
        } else {
          #if os(iOS)
            return orientationInfo.orientation == .portrait ? (getRect().width-52) :  (getRect().width-52)/2
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
