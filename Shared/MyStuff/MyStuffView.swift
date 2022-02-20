//
//  MyStuffView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct MyStuffView: View {
    @Binding var moviesNavigation : NavigationItem
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack{
                    Text("My Stuff!")
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
