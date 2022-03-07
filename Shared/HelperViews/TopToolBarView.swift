//
//  TopToolBarView.swift
//  MoviesApp
//
//  Created by Adinarayana-M on 22/2/2565 BE.
//

import SwiftUI

struct TopToolBarView: View {
    @Binding var isShowHomeCarousel: Bool
    @Binding var isShowTVShowsCarousel: Bool
    @Binding var isShowMoviesCarousel: Bool
    @Binding var isShowKidsCarousel: Bool
    @EnvironmentObject var settings : NavigationSettings
    @Binding var topBannerItems: TopBannerItems

    var body: some View {
        VStack{
            HStack(spacing:10){
                Button("Home") {
                    isShowTVShowsCarousel = false
                    isShowMoviesCarousel = false
                    isShowKidsCarousel = false
                    isShowHomeCarousel = true
                    self.topBannerItems = .home
                    self.settings.navigationItem = .toolBarHome
                }.frame(width: getWidthOfTopToolBarButtons(), height: getHeightOfTopToolBarButtons())
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: isMacOS() ? 18 : 14, weight: .bold))
                
                Button("TV Shows") {
                    isShowTVShowsCarousel = true
                    isShowMoviesCarousel = false
                    isShowKidsCarousel = false
                    isShowHomeCarousel = false
                    self.topBannerItems = .tvshows
                    self.settings.navigationItem = .toolBarTvShows
                }.frame(width: getWidthOfTopToolBarButtons(), height: getHeightOfTopToolBarButtons())
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: isMacOS() ? 18 : 14, weight: .bold))
                
                Button("Movies") {
                    isShowTVShowsCarousel = false
                    isShowMoviesCarousel = true
                    isShowKidsCarousel = false
                    isShowHomeCarousel = false
                    self.topBannerItems = .movies
                    self.settings.navigationItem = .toolBarMovies
                }.frame(width: getWidthOfTopToolBarButtons(), height: getHeightOfTopToolBarButtons())
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: isMacOS() ? 18 : 14, weight: .bold))
                
                Button("Kids") {
                    isShowTVShowsCarousel = false
                    isShowMoviesCarousel = false
                    isShowKidsCarousel = true
                    isShowHomeCarousel = false
                    self.topBannerItems = .kids
                    self.settings.navigationItem = .toolBarKids
                }.frame(width: 60, height: 38, alignment: .center)
                    .buttonStyle(.plain)
                    .foregroundColor(.white)
                    .font(.system(size: isMacOS() ? 18 : 14, weight: .bold))
                
            }.frame(width: getWidthOfTopToolBar(), height: getHeightOfTopToolBarButtons(), alignment: .center)
                .background(.clear)
            
            HStack(spacing:10){
                if isShowHomeCarousel{
                    Spacer().frame(width: getWidthOfTopToolBarButtons(), height: 2, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: getWidthOfTopToolBarButtons(), height: 2, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
                
                if isShowTVShowsCarousel{
                    Spacer().frame(width: getWidthOfTopToolBarButtons(), height: 2, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: getWidthOfTopToolBarButtons(), height: 2, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
                
                if isShowMoviesCarousel{
                    Spacer().frame(width: getWidthOfTopToolBarButtons(), height: 2, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: getWidthOfTopToolBarButtons(), height: 2, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
                if isShowKidsCarousel{
                    Spacer().frame(width: 60, height: 3, alignment: .center)
                        .background(.white)
                } else {
                    Spacer().frame(width: 60, height: 3, alignment: .leading)
                        .background(.white)
                        .hidden()
                }
            }.frame(width: getWidthOfTopToolBar(), height: 2, alignment: .center)
                .background(.clear)
                .padding([.leading,.trailing],0)
            
        }.frame(width: getWidthOfTopToolBar(), height: 40, alignment: .center)
            .background(.clear)
            .padding([.top, .bottom], 10)
    }
    
    func getWidthOfTopToolBarButtons() -> CGFloat {
        var width:CGFloat = 120
        if !isMacOS(){
            width = 70
        }
        return width
    }
    
    func getHeightOfTopToolBarButtons() -> CGFloat {
        var height:CGFloat = 37
        if !isMacOS(){
            height = 30
        }
        return height
    }
    
    func getWidthOfTopToolBar() -> CGFloat {
        var width:CGFloat = 460
        if !isMacOS(){
            width = 310
        }
        return width
    }
}


struct TopToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        TopToolBarView(isShowHomeCarousel: .constant(true), isShowTVShowsCarousel: .constant(false), isShowMoviesCarousel: .constant(false), isShowKidsCarousel:  .constant(false), topBannerItems: .constant(TopBannerItems.home))
    }
}
