//
//  GemListViewer.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

struct TabViewPage: View {
    var body: some View {
      TabView {
        NavigationView {
          MoviesListView()
            .listStyle(InsetGroupedListStyle())
        }
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
        .tag(NavigationItem.home)

        NavigationView {
            SearchView()
            .listStyle(InsetGroupedListStyle())
        }
        .tabItem {
          Label("Find", systemImage: "magnifyingglass")
        }
        .tag(NavigationItem.search)
        
          NavigationView {
              DownloadView()
              .listStyle(InsetGroupedListStyle())
          }
          .tabItem {
            Label("Downloads", systemImage: "arrow.down.circle")
          }
          .tag(NavigationItem.search)
          
          NavigationView {
              MyStuffView()
              .listStyle(InsetGroupedListStyle())
          }
          .tabItem {
            Label("My Stuff", systemImage: "person.circle.fill")
          }
          .tag(NavigationItem.search)
      }
    }
  }

struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}
