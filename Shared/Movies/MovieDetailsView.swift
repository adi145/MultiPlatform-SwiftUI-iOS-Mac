//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @EnvironmentObject var settings : NavigationSettings
    @State var selectedMovie : Movie!
#if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
#endif
    
    fileprivate func moreButton() -> some View {
        return Button(action: {
            print("More button was tapped")
        }) {
            VStack {
                Image(systemName: "ellipsis")
                    .font(.system(size: 25))
                    .rotationEffect(Angle(degrees: 90))
                    .padding([.top,.bottom], 10 )
                Text("More")
                    .font(.system(size: 10))
            }
        }
        .padding()
        .foregroundColor(.white)
    }
    
    fileprivate func downloadButton() -> some View {
        return Button(action: {
            print("Download button was tapped")
        }) {
            VStack {
                Image(systemName: "arrow.down.circle")
                    .font(.system(size: 22))
                    .padding(.bottom, 5)
                Text("Download")
                    .font(.system(size: 10))
            }
        }
        .padding()
        .foregroundColor(.white)
    }
    
    fileprivate func wishlistButton() -> some View {
        return Button(action: {
            print("Watchlist button was tapped")
        }) {
            VStack {
                Image(systemName: "plus")
                    .font(.system(size: 25))
                    .padding(.bottom, 5)
                Text("Watchlist")
                    .font(.system(size: 10))
            }
        }
        .padding()
        .foregroundColor(.white)
    }
    
    fileprivate func trailerButton() -> some View {
        return Button(action: {
            print("Trailer button was tapped")
        }) {
            VStack {
                Image(systemName: "play")
                    .font(.system(size: 25))
                    .padding(.bottom, 5)
                Text("Trailer")
                    .font(.system(size: 10))
            }
        }
        .padding()
        .foregroundColor(.white)
    }
    
    func getMovieItemHeight() -> CGFloat{
        if isMacOS(){
            return getRect().width/12
        } else {
#if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? (getRect().width)/1.9 : (getRect().height-92)/1.5
            : orientationInfo.orientation == .portrait ? (getRect().width-92)/3 : (getRect().height-92)/5
#endif
        }
        return 0
    }
    
    func getMovieItemWidth() -> CGFloat{
        if isMacOS(){
            return getRect().width/6
        } else {
#if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? getRect().width : getRect().width
            : orientationInfo.orientation == .portrait ? getRect().width-102 :  (getRect().height-92)/3.5
#endif
        }
        return 0
    }
    
    
    fileprivate func playButton() -> some View {
        return Button {
            print("Edit button was tapped")
        } label: {
            Label("Play", systemImage: "play.fill").foregroundColor(.white)
        }.frame(minWidth: 200, idealWidth: 300, maxWidth: 414, minHeight: 40, idealHeight: 45, maxHeight: 48, alignment: .leading)
            .background(.blue)
            .buttonStyle(.borderedProminent)
            .cornerRadius(5)
    }
    
    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                if isMacOS(){
                    HeaderViewMac(title: "Movie Details",onBackAction: backButton, isShowBackButton: true)
                }
                //Imageview
                VStack {
                    KFImage(selectedMovie.url)
                        .resizable()
                        .frame(width: getMovieItemWidth(), height: getMovieItemHeight(), alignment: .center)
                    Spacer()
                }
                .padding(.vertical, 0)
                
                VStack {
                    Text(selectedMovie.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                        .frame(height: 15, alignment: .center)
                    
                    playButton()
                    Spacer()
                        .frame(height: 15, alignment: .center)
                    
                    HStack(spacing:10) {
                        trailerButton()
                        wishlistButton()
                        downloadButton()
                        moreButton()
                    }
                    Spacer()
                        .frame(height: 15, alignment: .center)
                    Text(selectedMovie.description ?? "")
                        .font(.body)
                        .foregroundColor(.white)
                    
                }.frame(alignment: .top)
                    .padding([.leading, .trailing,.vertical], 16)
                
            } .conditionalNavigationTitle(isMacOS() ? true : false, title: selectedMovie.title ?? "")
                .onAppear {
                    print(selectedMovie.title ?? "")
                }.onDisappear {
                    if self.settings.selectedNavigationItem.count > 0{
                        self.settings.selectedNavigationItem.removeLast()
                    }
                }
        }
    }
    
    func backButton() {
        self.settings.navigationItem = self.settings.selectedNavigationItem.last ?? .main
    }
}
