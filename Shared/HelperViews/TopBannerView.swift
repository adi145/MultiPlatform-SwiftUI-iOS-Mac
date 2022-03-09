//
//  TopBannerView.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 22/2/2565 BE.
//

import SwiftUI

struct TopBannerView: View {
    var vm = MoviesListViewModel()
    @State var selectedCategory: String = ""
    var navigationItem : NavigationItem
    @EnvironmentObject var settings : NavigationSettings
    
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    @Binding var selectedMovie: Movie
     
    fileprivate func displayMoviesWithHorizontal(movie: Movie) -> some View {
        return StandardHomeMovie(movie: movie)
            .frame(width: getMovieItemWidth() , height: getMovieItemHeight())
            .cornerRadius(10)
            .padding(.horizontal, 5)
    }

    fileprivate func setupBannerView() -> some View {
        vm.navigationItem = navigationItem
        return ScrollView(.horizontal, showsIndicators: true) {
            LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: 1), spacing: 10) {
                ForEach(vm.getMovie(forCat: selectedCategory), id: \.self) { movie in
                    if isMacOS() {
                        displayMoviesWithHorizontal(movie: movie)
                            .onTapGesture {
                                self.selectedMovie = movie
                                self.settings.selectedNavigationItem.append(.home)
                                self.settings.navigationItem = NavigationItem.moviesDetails
                            }
                    } else {
                        NavigationLink(destination: MovieDetailsView(selectedMovie: movie)){
                            displayMoviesWithHorizontal(movie: movie)
                        }
                    }
                }
            }
        }.padding([.leading,.trailing], isMacOS() ? 30 : orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 16 : 0 : 16)
    }
    
    var body: some View {
        VStack {
            setupBannerView()
        }.frame(width: isMacOS() ? getRect().width-60 : getRect().width-32, height: getMovieItemHeight() )
            .padding(.bottom, 20)
            .padding([.leading,.trailing], isMacOS() ? 30 : orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 16 : 0 : 16)
            .cornerRadius(10)
        
    }
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return (getRect().width-60)/6
        } else {
          #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-32)/1.9 : (getRect().height-32)/1.9 : orientationInfo.orientation == .portrait ? (getRect().width-32)/4 : (getRect().height-32)/3.5
          #endif
        }
        return 0
    }
    
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return (getRect().width-60)/3.2
        } else {
          #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width-32)/1.15 :  (getRect().width-32)/2.2 : orientationInfo.orientation == .portrait ? (getRect().width-32)/2 :  (getRect().width-32)/2
          #endif
        }
        return 0
    }
}
