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
            navigateToMovieDetailsView
            TabView(selection: $selectedPage) {
                ForEach(0..<vm.getTopbannerList(topBannerItems: topBannerTems).count, id: \.self) { index in
                    StandardHomeMovie(movie: vm.getTopbannerList(topBannerItems: topBannerTems)[index])
                        .frame(width: isMacOS() ? 150 : getRect().width, height: isMacOS() ? 150 : (getRect().width)/2.5)
                        .cornerRadius(5)
                        .tag(index)
                        .padding(.horizontal, 0).onTapGesture {
                            self.selectedMovie = vm.getTopbannerList(topBannerItems: topBannerTems)[index]
                            if isMacOS() {
                                self.settings.navigationItem = .moviesDetails
                            } else {
                                self.settings.isNavigateMovieDetailsScreen = true
                            }
                        }
                    
                }
            }
//            .tabViewStyle(.automatic)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }.frame(width: isMacOS() ? nil: getRect().width, height: getTopBarHeight() ).padding(.bottom, 20)
    }
    
    func getTopBarHeight() -> CGFloat{
        if isMacOS(){
            return 150
        } else {
          #if os(iOS)
            return orientationInfo.orientation == .portrait ? getRect().width/2.5 : getRect().height/2.5
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
