//
//  AllMoviesListView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI
import Kingfisher

struct SeeMoreView: View {
    var vm = MoviesListViewModel()
    var selectedCategory = ""
    var navigationItem : NavigationItem!
    @EnvironmentObject var settings : NavigationSettings
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    @State var gridColums: [GridItem] = []

    let columns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible()),
    ]
    
    func getCount() -> Int{
        if isMacOS(){
            return 5
        } else {
           #if os(iOS)
            print(getRect().width)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 2 : 3 : orientationInfo.orientation == .portrait ? 3 : getRect().width > 1000 ? 5 : 4
           #endif
        }
        return 0
    }
    
    fileprivate func displayAllMovies(movie: Movie) -> some View {
        return HStack {
            StandardHomeMovie(movie: movie).cornerRadius(2)
        }
        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100)
        .background(Color.black)
        .cornerRadius(5)
    }
    
    func getMainView() -> some View {
        vm.navigationItem = navigationItem
        return VStack{
            if isMacOS(){
                HeaderViewMac(title: "See more",onBackAction: backButton, isShowBackButton: true)
            }
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: getCount()), spacing: 10) {  // HERE 2
                    ForEach((vm.getMovie(forCat: selectedCategory))) { movie in
                        if isMacOS() {
                            displayAllMovies(movie: movie)
                                .onTapGesture {
                                }
                        } else {
                            NavigationLink(destination: MovieDetailsView(selectedMovie: movie)){
                                displayAllMovies(movie: movie)
                            }
                        }
                    }
                }
                .padding([.leading,.trailing], 16)
            }.navigationTitle(Text(selectedCategory))
        }
    }
    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            VStack{
                getMainView()
            }.onAppear {
//                vm.navigationItem = navigationItem
            }
        }.background(.orange)
    }
    
    func backButton() {
        settings.navigationItem = .home
    }
}
