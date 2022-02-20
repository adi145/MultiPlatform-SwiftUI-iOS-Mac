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
    @Binding var selectedMovie: Movie?
    @State var gridColums: [GridItem] = []
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                HeaderViewMac(title: "See More", onBackAction: backButton, isShowBackButton: true)
                ScrollView {
                    LazyVGrid(columns: gridColums) {
                        ForEach(vm.getMovie(forCat: selectedCategory)){ movie in
                            StandardHomeMovie(movie: movie)
                                .frame(width: 150, height: 200)
                                .padding([.horizontal,.vertical], 20)
                                .onTapGesture {
                                    self.selectedMovie = movie
                                    self.settings.selectedNavigationItem = .seeMore
                                    self.settings.navigationItem = .moviesDetails
                                }
                        }
                    }.padding([.leading,.trailing], 10)
                }
            }.padding([.leading,.trailing], 20)
        }
            .onAppear(){
                self.vm.navigationItem = navigationItem
            let windowWidth = isMacOS() ? getRect().width : nil
            print("windowWidth +++",windowWidth ?? 0.0)
            let totalColums = windowWidth!/150
            print("totalColums +++",totalColums)
            let totalWidth = windowWidth! - 40 - totalColums * 10
            print("totalWidth +++",totalWidth)
            let totalColumsAfterPadding = windowWidth!/150
            print("totalColumsAfterPadding +++",totalColumsAfterPadding)
            print("totalColumsAfterPadding +++",Int(totalColumsAfterPadding))
            for _ in 0..<Int(totalColumsAfterPadding) {
                self.gridColums.append(GridItem(.flexible()))
            }
            print("catogoery",self.selectedCategory)
                print("gridColoums",self.gridColums.count)
                print("gridColoums",self.gridColums)
            print("gridColoums",self.navigationItem)
            print("gridColoums",self.vm.navigationItem)

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
