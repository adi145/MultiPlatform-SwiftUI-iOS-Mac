//
//  MyStuffView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct MyStuffView: View {

    var body: some View {
        NavigationView{
            ZStack {
                ColorTheme.bgColor.color
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    if isMacOS(){
                        HeaderViewMac(title: "My Stuff")
                    }
                    Text("My Stuff")
                }.conditionalView(isMacOS() ? true : false, title: "My Stuff")
            }
        }.conditionalNavigationStyle(isMacOS())
    }
}
