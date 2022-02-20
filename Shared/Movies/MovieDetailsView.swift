//
//  MovieDetailsView.swift
//  MoviesApp
//
//  Created by Adinarayana on 16/02/22.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    @AppStorage("selectedAppearance") var selectedAppearance = 0
    @Binding var moviesNavigation: NavigationItem
    var movie : Movie!
    var body: some View {
        ZStack {
            VStack{
                Button {
                    print("Back button was tapped")
                    moviesNavigation = .home
                } label: {
                    Image(systemName: "chevron.left").background(.clear)
                }
            }.frame(width: isMacOS() ? getRect().width : nil , height: 44, alignment: .leading)
            .background(.black)
            Spacer()
//            VStack{
//
//                Text("Moview Details")
//            }.onTapGesture {
//                self.moviesNavigation = NavigationItem.home
//            }
        }
//        .preferredColorScheme(selectedAppearance == 1 ? .light : selectedAppearance == 2 ? .dark : nil)
        //.preferredColorScheme(nil)
    }

    func backButton() {
        moviesNavigation = .home
    }
}

//struct MovieDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailsView()
//    }
//}
