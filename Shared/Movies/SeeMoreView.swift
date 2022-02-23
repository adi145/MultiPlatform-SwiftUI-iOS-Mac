//
//  AllMoviesListView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

struct SeeMoreView: View {
    var vm = MoviesListViewModel()
    var selectedCategory = ""
    var navigationItem : NavigationItem!
    @EnvironmentObject var settings : NavigationSettings
    @State var gridColums: [GridItem] = []
    @Binding var selectedMovie: Movie?
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                if isMacOS(){
                    HeaderViewMac(title: "See More", onBackAction: backButton, isShowBackButton: true)
                }
                ScrollView {
                    LazyVGrid(columns: gridColums) {
                        ForEach(vm.getMovie(forCat: selectedCategory)){ movie in
                            StandardHomeMovie(movie: movie)
                                .frame(width: isMacOS() ? 150 : (getRect().width-52)/2, height: isMacOS() ? 150 : (getRect().width-52)/3.5)
                                .onTapGesture {
                                    self.selectedMovie = movie
                                    self.settings.selectedNavigationItem = .seeMore
                                    self.settings.navigationItem = .moviesDetails
                                }
                        }
                    }.padding([.leading,.trailing],0)
                        .background(.red)
                    //                    .padding()
                    //                    .padding([.vertical], 10)
                }.padding([.leading,.trailing],0)
                    .background(.orange)
            }.padding([.leading,.trailing],0)
                .background(.gray)
            //.padding([.leading,.trailing], 16)
        }.padding([.leading,.trailing],0)
            .background(.white)
        .onAppear(){
            if !isMacOS() {
                //Use this if NavigationBarTitle is with Large Font
                UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color.red]
                //Use this if NavigationBarTitle is with displayMode = .inline
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            }
            self.vm.navigationItem = navigationItem
            let windowWidth = isMacOS() ? getRect().width : getRect().width-52
            print("windowWidth +++",windowWidth )
            let totalColums = isMacOS() ? windowWidth/150 : (windowWidth/2)/(windowWidth/2)
            print("totalColums +++",totalColums)
            let totalWidth = windowWidth - 40 - totalColums * 10
            print("totalWidth +++",totalWidth)
            let totalColumsAfterPadding = windowWidth/(windowWidth/2)
            print("totalColumsAfterPadding +++",totalColumsAfterPadding)
            print("totalColumsAfterPadding +++",Int(totalColumsAfterPadding))
            for _ in 0..<Int(totalColumsAfterPadding) {
                self.gridColums.append(GridItem(.fixed((getRect().width-52)/2), spacing: 10))
            }
        }
    }
    
    func backButton() {
        self.settings.navigationItem = .home
    }
}
//
//struct AllMoviesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllMoviesListView()
//    }
//}
