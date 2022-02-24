//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @EnvironmentObject var settings : NavigationSettings
    var navigationItem: NavigationItem
    var movie : Movie!
   
    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            VStack{
                if isMacOS(){
                    HeaderViewMac(title: "Movie Details",onBackAction: backButton, isShowBackButton: true)
                }
            }.navigationTitle(Text("Movie Details"))
//                .navigationViewStyle(.automatic)
            .onAppear {
            }
        }
    }
    
    func backButton() {
        settings.navigationItem = settings.selectedNavigationItem.last ?? .home
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView()
//    }
//}
