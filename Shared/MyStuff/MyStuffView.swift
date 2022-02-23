//
//  MyStuffView.swift
//  MoviesApp
//
//  Created by Adinarayana on 19/02/22.
//

import SwiftUI

struct MyStuffView: View {
    
    @EnvironmentObject var settings : NavigationSettings

    var body: some View {
        ZStack {
            ColorTheme.bgColor.color
                .edgesIgnoringSafeArea(.all)
            VStack{
                if isMacOS(){
                HeaderViewMac(title: "My Stuff")
                }
                Text("My Stuff")
            }.background(Color.red)
        }
        
    }
}
