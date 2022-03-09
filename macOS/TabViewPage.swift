//
//  GemListViewer.swift
//  MoviesApp (macOS)
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI

struct TabViewPage: View {
    var body: some View {
        MoviesListView(selectedCategory: "", navigationItem: .main, findNavigationItem: .find)
            .frame(maxWidth: isMacOS() ? getRect().width : getRect().width, maxHeight: isMacOS() ? getRect().height : getRect().height)
                    .background(ColorTheme.bgColor.color)
        }
  }

struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}
 
