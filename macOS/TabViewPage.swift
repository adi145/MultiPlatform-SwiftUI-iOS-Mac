//
//  GemListViewer.swift
//  MoviesApp (macOS)
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

struct TabViewPage: View {
//    @State var navigationItem = NavigationItem.home
//    @State var selectedCategory: String?
//    @State var selectedMovie: Movie?
//      @EnvironmentObject var settings : NavigationSettings
//    @State var toolbarNavigation : ToolBarNaviagtionItems = .home

    var body: some View {
//        VStack{
        MoviesListView(navigationItem: .home)
            .frame(maxWidth: isMacOS() ? getRect().width : getRect().width, maxHeight: isMacOS() ? getRect().height : getRect().height)
                    .background(ColorTheme.bgColor.color)
//                    .transition(AnyTransition.move(edge: .leading)).animation(.default)
//            }
        }
    
  }

struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}
 
