//
//  SearchView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI
import Kingfisher

struct FinderView: View {
    var vm = MoviesListViewModel()
    var selectedCategory = "Top movies"
    var navigationItem : NavigationItem!
    @EnvironmentObject var settings : NavigationSettings
    #if os(iOS)
    @EnvironmentObject var orientationInfo: OrientationInfo
    #endif
    @State var gridColums: [GridItem] = []
    @State var names = [Movie]()//["Holly", "Josh", "Rhonda", "Ted"]
    @State var searchText = ""
    let columns = [
        GridItem(.flexible(), alignment: .center),
        GridItem(.flexible()),
    ]
    
    func getCount() -> Int{
        if isMacOS(){
            return 5
        } else {
           #if os(iOS)
            return orientationInfo.deviceType == .iphone ? orientationInfo.orientation == .portrait ? 2 : 3 : orientationInfo.orientation == .portrait ? 3 : getRect().width > 1000 ? 5 : 4
           #endif
        }
        return 0
    }
    
    fileprivate func displayAllMovies(category: String) -> some View {
        return HStack {
            VStack{
                Image("1")
                    .resizable()
                    .scaledToFill()
                    .overlay(alignment: .center) {
                        Text(category).foregroundColor(.white)
                    }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 100)
        .background(Color.black)
        .cornerRadius(5)
    }
    
    fileprivate func returnSelectedCategory(navigationItem: NavigationItem, category: String) -> AnyView {
        return AnyView(MoviesHome(title: category, navigationItem: navigationItem))
    }
    
    fileprivate func navigateToSelectedTab(_ category: String) -> AnyView {
        if category == "Movies" {
            return returnSelectedCategory(navigationItem: .movies, category: category)
        } else if category == "TV" {
            return returnSelectedCategory(navigationItem: .TV, category: category)
        } else if category == "Kids" {
            return returnSelectedCategory(navigationItem: .kids, category: category)
        }
        return AnyView(SeeMoreView(selectedCategory: category, navigationItem:.find))
    }
    
    init() {
        UITableView.appearance().separatorStyle = .singleLine
        UITableViewCell.appearance().backgroundColor = UIColor(red: 13.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        UITableView.appearance().backgroundColor = UIColor(red: 13.0/255.0, green: 23.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    }
    
    func getMainView() -> some View {
        vm.navigationItem = .find
        return VStack{
            if isMacOS(){
                HeaderViewMac(title: "See more",onBackAction: backButton, isShowBackButton: true)
            }
            if !searchText.isEmpty {
                List {
                    ForEach(searchResults, id: \.self) { movie in
                        NavigationLink(destination: Text(movie.title ?? "")) {
                            Text(movie.title ?? "").foregroundColor(.red)
                        }
                    }.listRowBackground(ColorTheme.bgColor.color)
                } .listStyle(GroupedListStyle())
                    .background(.red)
            } else {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10, alignment: .center), count: getCount()), spacing: 10) {  // HERE 2
                        ForEach(vm.allHomeMoviesCategories, id: \.self) { category in
                            if isMacOS() {
                                displayAllMovies(category: category)
                                    .onTapGesture {
                                        self.settings.isFromSeeMoreToMovieDetailsScreen = true
                                    }
                            } else {
                                NavigationLink(destination: navigateToSelectedTab(category)){
                                    displayAllMovies(category: category)
                                }
                            }
                        }
                    }
                    .padding([.leading,.trailing], 16)
                }
            }
            
        }
    }
    
    var searchResults: [Movie] {
          if searchText.isEmpty {
              return exampleMovies
          } else {
              return exampleMovies.filter { $0.title?.contains(searchText) as! Bool }
          }
      }
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorTheme.bgColor.color
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    getMainView()
                }
            }
            .conditionalNavigationTitle(isMacOS() ? true : false, title: "")
                .onAppear {
                    
                }
        }.navigationBarHidden(true)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
//        {
//                ForEach(searchResults, id: \.self) { result in
//                    Text("\(result.title ?? "")").searchCompletion(result.title ?? "")
//                               }
//            }
            .foregroundColor(.white)
        
        .conditionalNavigationStyle(isMacOS())
    }
    
    func backButton() {
        settings.navigationItem = .home
    }
}

extension View {
    func conditionalNavigationTitle(_ value: Bool, title:String) -> some View {
        self.modifier(ConditionalModifier(isBold: value, title: title))
  }
    func conditionalNavigationStyle(_ value: Bool) -> some View {
        self.modifier(ConditionalNavigationStyleModifier(isMacOS: value))
  }
    
}
struct ConditionalNavigationStyleModifier: ViewModifier {
    var isMacOS: Bool
    func body(content: Content) -> some View {
        Group {
            if isMacOS {
                content.navigationViewStyle(.automatic)
            }else{
               #if os(iOS)
                content.navigationViewStyle(StackNavigationViewStyle())
               #endif
            }
        }
    }
}
struct ConditionalModifier: ViewModifier {
    var isBold: Bool
    var title: String
    func body(content: Content) -> some View {
    Group {
        if self.isBold {
            content.navigationTitle(Text(title))
        }else{
            #if os(iOS)
            content.navigationBarTitle(Text(title), displayMode: .inline)
            #endif
          
           #if os(tvOS)
            content.navigationTitle(Text(title))
             #endif
            }
        }
    }
  }

