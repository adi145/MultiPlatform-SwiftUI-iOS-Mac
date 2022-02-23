//
//  GemListViewer.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

enum TabItems: Int {
    case home, find, downloads, mystuff
}
 
struct TabViewPage: View {
  
//    @EnvironmentObject var settings : NavigationSettings
    @State var navigationTitle = "Movies"
    @State private var selectedTab = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var tabIndex = -1
    
    init() {
        UITabBar.appearance().barTintColor = .black
    }
    
    var body: some View {
        
        let selection = Binding<Int>(
            get: { self.selectedTab },
            set: { self.selectedTab = $0
                print("Pressed tab: \($0)")
                self.tabIndex = $0
                if $0 == 1 {
                    self.navigationTitle = "Home"
                } else if $0 == 2 {
                    self.navigationTitle = "Find"
                } else if $0 == 3 {
                    self.tabIndex = 3
                    self.navigationTitle = "Downloads"
                }else if $0 == 4 {
                    self.tabIndex = 4
                    self.navigationTitle = "MyStuff"
                }
            })
        return TabView(selection: selection) {
            NavigationView{
              MoviesListView().navigationBarTitle("NavBar title Tabbar1", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "house.fill").imageScale(.medium).foregroundColor(Color.accentColor)
                Text("Home")
            }.tag(1)
            
            NavigationView{
                FinderView().navigationBarTitle("NavBar title Tabbar1", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "magnifyingglass").imageScale(.medium).foregroundColor(Color.accentColor)
                Text("Find")
            }.tag(2)
            
            NavigationView{
                DownloadView().navigationBarTitle("NavBar title Tabbar1", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "arrow.down.circle").imageScale(.small).foregroundColor(Color.accentColor)
                Text("Downloads")
            }.tag(3)
            
            NavigationView{
            MyStuffView().navigationBarTitle("NavBar title Tabbar1", displayMode: .inline)
            }
                .tabItem {
                    Image(systemName: "person.circle.fill").font(.system(size: 10)).foregroundColor(Color.accentColor)
                    Text("My Stuff")
                }.tag(4)
                
            
        }
        .navigationBarTitle(Text(self.navigationTitle), displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: self.tabIndex == 4 ?
            AnyView(self.navigationBarButton) : AnyView(EmptyView()))
    }
    
    var navigationBarButton: some View {
     Button(action: {
//        SaveUser.remove(key: SaveUser.login_username)
       // UserDefaults.standard.set("", forKey: "login")
//        self.settings.isNavigateToHomeScreen = false
      }) {
          Text("Logout").foregroundColor(.red)
      }
    }
}

/*struct TabViewPage: View {
    @State private var selectedTab = TabItems.home.rawValue

    init() {
        UITabBar.appearance().barTintColor = .black
    }
    
    var body: some View {
      TabView(selection: $selectedTab) {
        NavigationView {
          MoviesListView()
                .background(ColorTheme.bgColor.color)
//            .listStyle(InsetGroupedListStyle())
        }
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
        .tag(TabItems.home.rawValue)

        NavigationView {
            FinderView()
                .background(ColorTheme.bgColor.color)
//            .listStyle(InsetGroupedListStyle())
        }
        .tabItem {
          Label("Find", systemImage: "magnifyingglass")
        }
        .tag(TabItems.find.rawValue)
        
          NavigationView {
              DownloadView()
                  .background(ColorTheme.bgColor.color)
//              .listStyle(InsetGroupedListStyle())
          }
          .tabItem {
            Label("Downloads", systemImage: "arrow.down.circle")
          }
          .tag(TabItems.downloads.rawValue)
          
          NavigationView {
              MyStuffView()
                  .background(ColorTheme.bgColor.color)
//              .listStyle(InsetGroupedListStyle())
          }
          .tabItem {
            Label("My Stuff", systemImage: "person.circle.fill")
          }
          .tag(TabItems.mystuff.rawValue)
      }
    }
  }*/

struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}
