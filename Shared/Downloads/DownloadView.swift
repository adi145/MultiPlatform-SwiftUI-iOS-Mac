//
//  DownloadView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct DownloadView: View {
    @Binding var moviesNavigation : NavigationItem

    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    Text("Downloads!")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                    
                }.frame(width: isMacOS() ? getRect().width : nil , height: 44, alignment: .center)
                    .background(.black)
                    .onTapGesture {
                        moviesNavigation = .home
                    }
                Spacer()
            }
        }
        
    }
}

//struct DownloadView_Previews: PreviewProvider {
//    static var previews: some View {
//        DownloadView()
//    }
//}
