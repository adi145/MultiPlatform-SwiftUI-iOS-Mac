//
//  DownloadView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct DownloadView: View {
//    @Binding var navigationItem : NavigationItem
    @EnvironmentObject var settings : NavigationSettings

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
//                .navigationBarTitle(Text("Downloads"), displayMode: .inline)
                .conditionalView(isMacOS() ? true : false, title: "Downloads")
            }
        }
    }
        
}

//struct DownloadView_Previews: PreviewProvider {
//    static var previews: some View {
//        DownloadView()
//    }
//}
