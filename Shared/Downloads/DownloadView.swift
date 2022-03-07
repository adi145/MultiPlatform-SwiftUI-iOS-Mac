//
//  DownloadView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct DownloadView: View {

    var body: some View {
        NavigationView{
            ZStack {
                ColorTheme.bgColor.color
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    if isMacOS() {
                        HeaderViewMac(title: "Downloads")
                    }
                }
                .conditionalView(isMacOS() ? true : false, title: "Downloads")
            }
        }.conditionalNavigationStyle(isMacOS())
    }
        
}

//struct DownloadView_Previews: PreviewProvider {
//    static var previews: some View {
//        DownloadView()
//    }
//}
