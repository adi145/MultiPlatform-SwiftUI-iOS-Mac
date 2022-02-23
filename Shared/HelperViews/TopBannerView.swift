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
    
    var body: some View {
        VStack {
            TabView(selection: $selectedPage) {
                ForEach(0..<vm.getTopbannerList(topBannerItems: topBannerTems).count, id: \.self) { index in
                    StandardHomeMovie(movie: vm.getTopbannerList(topBannerItems: topBannerTems)[index])
                        .frame(width: isMacOS() ? 150 : getRect().width, height: isMacOS() ? 150 : (getRect().width)/2.5)
                        .cornerRadius(5)
                        .tag(index)
                        .padding(.horizontal, 0).onTapGesture {
//                            self.selectedMovie = movie
//                            self.settings.navigationItem = NavigationItem.moviesDetails
                        }
                        
                }
            }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }
}

struct TopBannerView_Previews: PreviewProvider {
    static var previews: some View {
        TopBannerView()
    }
}
