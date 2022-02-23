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
            VStack{
                if isMacOS(){
                    HeaderViewMac(title: "Movie Details",onBackAction: backButton, isShowBackButton: true)
                }
            }
        }.onAppear {
            if !isMacOS() {
                //Use this if NavigationBarTitle is with Large Font
                UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: ColorTheme.bgColor.color]
                //Use this if NavigationBarTitle is with displayMode = .inline
                UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            }
        }
    }

    func backButton() {
        settings.navigationItem = settings.selectedNavigationItem
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView()
//    }
//}
