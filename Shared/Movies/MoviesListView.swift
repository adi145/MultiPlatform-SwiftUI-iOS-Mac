//
//  ContentView.swift
//  Shared
//
//  Created by Adinarayana on 15/02/22.
//

import SwiftUI
import Kingfisher

struct MoviesListView: View {
    @Binding var moviesNavigation: NavigationItem
    @Binding var selectedCategory: String?
    @Binding var selectedMovie: Movie?
    var vm = MoviesListViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    Text("Movies")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                }.frame(width: isMacOS() ? getRect().width : nil , height: 44, alignment: .center)
                    .background(.black)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(vm.allCategories, id: \.self) { category in
                            VStack {
                                HStack {
                                    Text(category)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .bold().padding(.leading, 10)
                                    Image(systemName: "chevron.right")
                                    Spacer()
                                }.foregroundColor(.white)
                                    .onTapGesture {
                                        self.selectedCategory = category
                                        self.moviesNavigation = NavigationItem.seeMore
                                    }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack {
                                        ForEach(vm.getMovie(forCat: category)) { movie in
                                            StandardHomeMovie(movie: movie)
                                                .frame(width: 125, height: 200)
                                                .padding(.horizontal, 10).onTapGesture {
                                                    self.selectedMovie = movie
                                                    self.moviesNavigation = NavigationItem.moviesDetails
                                                }
                                        }
                                    }
                                }
                            }.foregroundColor(.white)
                        }
                    }
                }
                VStack{
                HStack{
                    Spacer()
                    Button(action: homeAction) {
                      Label("Home", systemImage: "house.fill")
                    }
                    Spacer()
                    Button(action: findAction) {
                      Label("Find", systemImage: "magnifyingglass")
                    }
                    Spacer()
                    Button(action: downloadAction) {
                      Label("Downloads", systemImage: "arrow.down.circle")
                    }
                    Spacer()
                    Button(action: myStuffAction) {
                        Label("MyStuff", systemImage: "person.circle.fill").foregroundColor(.blue)
                    }.background(.clear)
                    Spacer()
                }.frame(width: isMacOS() ? getRect().width : nil , height: 44, alignment: .center)
                }.frame(width: isMacOS() ? getRect().width : nil , height: 44, alignment: .center)
                    .background(.black)
            }
        }
        //        .foregroundColor(.white)
        //        .navigationBarTitle("Movies", displayMode: .inline)
        //        .navigationBarHidden(true)
    }
    
    func homeAction() {
        moviesNavigation = .home
    }
    func findAction() {
        moviesNavigation = .find
    }
    func downloadAction() {
        moviesNavigation = .downloads
    }
    func myStuffAction() {
        moviesNavigation = .mystuff
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesListView(show: false)
//    }
//}
