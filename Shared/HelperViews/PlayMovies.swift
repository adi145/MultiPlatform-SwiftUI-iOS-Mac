//
//  PlayMovies.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 8/3/2565 BE.
//

import SwiftUI
import AVKit

struct PlayMovies: View {
    
    var vm = MoviesListViewModel()
    @State var selectedCategory: String = ""
    var navigationItem : NavigationItem
    @EnvironmentObject var settings : NavigationSettings
    let videoUrl = URL(fileURLWithPath: Bundle.main.path(forResource: "big_buck_bunny_720p_1mb", ofType: "mp4")!)
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    @State var selectedMovie: Movie?
    
    fileprivate func displayMoviesWithHorizontal(movie: Movie) -> some View {
        return VideoPlayer(player: AVPlayer(url: videoUrl), videoOverlay: {
        }).frame(width: getMovieItemWidth() , height: getMovieItemHeight())
            .cornerRadius(10)
    }
    
    fileprivate func setupBannerView() -> some View {
        vm.navigationItem = navigationItem
        return ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1), spacing: 10) {
                ForEach(vm.getMovie(forCat: selectedCategory), id: \.self) { movie in
                    displayMoviesWithHorizontal(movie: movie)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                setupBannerView()
            }
        }.frame(width: isMacOS() ? getRect().width-60 : getRect().width-32, height: getMovieItemHeight() ).padding(.bottom, 20)
            .cornerRadius(10)
        
    }
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return (getRect().width-60)/6
        } else {
           #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width)/1.9 : (getRect().height)/1.9 : orientationInfo.orientation == .portrait ? (getRect().width)/4 : (getRect().height)/3.5
            #endif
        }
        return 0
    }
    
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return (getRect().width-60)/3.2
        } else {
            #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-62) :  (getRect().width-72)/2.2 : orientationInfo.orientation == .portrait ? (getRect().width-82)/2 :  (getRect().width-82)/2
            #endif
        }
        return 0
    }
}

